import json
from jaxfluids import InputReader, Initializer, SimulationManager

numerical_setup_dict    = json.load(open("numerical_setup.json"))
case_setup_dict         = json.load(open("case_setup.json"))

input_reader        = InputReader(case_setup_dict, numerical_setup_dict)
initializer         = Initializer(input_reader)
simulation_manager  = SimulationManager(input_reader)

initial_buffer      = initializer.initialization()
simulation_manager.simulate(initial_buffer)