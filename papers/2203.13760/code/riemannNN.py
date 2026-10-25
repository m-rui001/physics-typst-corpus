from functools import partial
from typing import Callable, Dict
from xxlimited import Str
import jax, haiku as hk, jax.numpy as jnp
from jaxfluids import MaterialManager, RiemannSolver, get_fluxes_xi

class RusanovNN(RiemannSolver):

    def __init__(self, material_manager: MaterialManager, signal_speed: Callable) -> None:
        super(RusanovNN, self).__init__(material_manager=material_manager, signal_speed=signal_speed)

    @partial(jax.jit, static_argnums=(0,5,7))
    def solve_riemann_problem_xi(self, primitives_L: jnp.array, primitives_R: jnp.array,
        conservatives_L: jnp.array, conservatives_R: jnp.array, axis: int,
        network_params: Dict[str, hk.Params], network_module: Dict[str, hk.Transformed]) -> jnp.array:
        
        rho_L, rho_R    = primitives_L[0], primitives_R[0] 
        p_L, p_R        = primitives_L[4], primitives_R[4]
        u_L, u_R        = primitives_L[axis + 1], primitives_R[axis + 1]

        # PHYSICAL FLUXES
        fluxes_left     = get_fluxes_xi(primitives_L, conservatives_L, axis + 1)
        fluxes_right    = get_fluxes_xi(primitives_R, conservatives_R, axis + 1)

        # COMPUTE MEAN SPEAD OF SOUND AT CELL FACE
        speed_of_sound_left     = self.material_manager.get_speed_of_sound(p_L, rho_L)
        speed_of_sound_right    = self.material_manager.get_speed_of_sound(p_R, rho_R)
        mean_speed_of_sound     = 0.5 * (speed_of_sound_left + speed_of_sound_right)

        # COMPUTE MEAN ENTROPY AT CELL FACE
        entropy_L       = self.material_manager.get_entropy(p_L, rho_L)
        entropy_R       = self.material_manager.get_entropy(p_R, rho_R)
        delta_entropy   = jnp.abs(entropy_R - entropy_L)

        # COMPUTE MEAN NORMAL VELOCITY AT CELL FACE
        delta_vel  = jnp.abs(u_R - u_L)
        mean_vel   = 0.5 * (u_L + u_R)

        # FEED FORWARD NEURAL NETWORK
        input_array     = jnp.stack([delta_vel, mean_vel, mean_speed_of_sound, delta_entropy])
        dissipation     = network_module["alpha"].apply(network_params["alpha"], input_array)

        return 0.5 * (fluxes_left + fluxes_right - dissipation * (conservatives_R - conservatives_L) )
