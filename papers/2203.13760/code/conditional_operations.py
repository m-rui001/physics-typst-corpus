from functools import partial
import jax, jax.numpy as jnp

class LevelsetHandler():
    def __init__(self, ...) -> None:
        pass

    @partial(jax.jit, static_argnums=(0, 3))
    def compute_levelset_advection_rhs_xi(self, levelset: jnp.array, interface_velocity: jnp.array,
            axis: int) -> jnp.array:

        # LEFT AND RIGHT SIDED DERIVATIVE
        derivative_L = self.spatial_derivative.derivative_xi(levelset, self.cell_sizes[axis], axis, 0)
        derivative_R = self.spatial_derivative.derivative_xi(levelset, self.cell_sizes[axis], axis, 1)

        # UPWINDING DEPENDING ON LOCAL INTERFACE VELOCITY
        velocity    = interface_velocity[axis]
        mask_L      = jnp.where(velocity >= 0.0, 1.0, 0.0)
        mask_R      = 1.0 - mask_L

        # RIGHT-HAND-SIDE EVALUATION
        rhs_contribution = - velocity * (mask_L * derivative_L + mask_R * derivative_R)

        return rhs_contribution