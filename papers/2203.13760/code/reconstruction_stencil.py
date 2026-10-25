from functools import partial
import jax, jax.numpy as jnp
from jaxfluids.stencils.spatial_reconstruction import SpatialReconstruction

class CentralSecondOrderReconstruction(SpatialReconstruction):

    def __init__(self, nh: int, inactive_axis: jnp.array) -> None:
        super(CentralSecondOrderReconstruction, self).__init__(nh=nh, inactive_axis=inactive_axis)
        self.slices = [
            [   jnp.s_[..., self.nh-1:-self.nh  , self.nhy, self.nhz],         #  X-DIRECTION          
                jnp.s_[..., self.nh  :-self.nh+1, self.nhy, self.nhz],   ],

            [   jnp.s_[..., self.nhx, self.nh-1:-self.nh  , self.nhz],         #  Y-DIRECTION   
                jnp.s_[..., self.nhx, self.nh  :-self.nh+1, self.nhz],   ],   

            [   jnp.s_[..., self.nhx, self.nhy, self.nh-1:-self.nh  ],         #  Z-DIRECTION 
                jnp.s_[..., self.nhx, self.nhy, self.nh  :-self.nh+1],   ],   
        ]

    @partial(jax.jit, static_argnums=(0, 2))
    def reconstruct_xi(self, buffer: jnp.array, axis: int) -> jnp.array:
        s_ = self.slices[axis]
        cell_face_state_xi = 0.5 * ( buffer[s_[0]] + buffer[s_[1]] )
        return cell_face_state_xi