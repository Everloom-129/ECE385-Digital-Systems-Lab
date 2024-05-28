import graphviz

# Create a new directed graph for the FSM visualization
dot = graphviz.Digraph(comment='ISDU FSM', format='png')

# Define the states
states = ["Halted", "PauseIR1", "PauseIR2", "S_18", "S_33_1", "S_33_2", "S_35", "S_32",
          "S_01", "S_05", "S_09", "S_06", "S_25_1", "S_25_2", "S_27", "S_07", "S_23",
          "S_16_1", "S_16_2", "S_04", "S_21", "S_12", "S_00", "S_22"]

# Add states to the graph
for state in states:
    dot.node(state, state)

# Define transitions
transitions = [
    ("Halted", "S_18", "Run"),
    ("S_18", "S_33_1", ""),
    ("S_33_1", "S_33_2", ""),
    ("S_33_2", "S_35", ""),
    ("S_35", "PauseIR1", ""),
    ("PauseIR1", "PauseIR1", "~Continue"),
    ("PauseIR1", "PauseIR2", "Continue"),
    ("PauseIR2", "PauseIR2", "Continue"),
    ("PauseIR2", "S_18", "~Continue"),
    # Example transitions for S_32 based on Opcode
    ("S_32", "S_01", "Opcode=0001"),
    ("S_32", "S_05", "Opcode=0101"),
    ("S_32", "S_09", "Opcode=1001"),
    ("S_32", "S_06", "Opcode=0110"),
    ("S_32", "S_07", "Opcode=0111"),
    ("S_32", "S_04", "Opcode=0100"),
    ("S_32", "S_12", "Opcode=1100"),
    ("S_32", "S_00", "Opcode=0000"),
    # Skipping others for brevity
    ("S_01", "S_18", ""),
    ("S_05", "S_18", ""),
    ("S_09", "S_18", ""),
    # Skipping to show a loop and final transitions
    ("S_00", "S_22", "BEN"),
    ("S_00", "S_18", "~BEN"),
    ("S_22", "S_18", ""),
    # Transition back to Halted as an example of a possible reset or end
    # This is not directly from the code but illustrates the idea of a system reset or completion
]

# Add transitions to the graph
for start, end, label in transitions:
    dot.edge(start, end, label=label)

# Render the graph to a file and display it
dot.render('./draw/ISDU_FSM.png')

dot
