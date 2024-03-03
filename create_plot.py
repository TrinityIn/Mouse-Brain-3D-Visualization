import pandas as pd

# Read data from CSV file
csv_file_path = r'/path/to/file/Closed_data.csv'
data = pd.read_csv(csv_file_path, header=None)

# Output directory
output_directory = r'/path/to/output/closed/'

# Iterate over the range and generate OBJ files
for x in range(1, 100):  # Adjusted range from 1 to 14
    # Extract data from cells Bx to DQx
    row_data = data.iloc[x, 1:120].values  # Adjusted index range to 1:108

    # Define OBJ file path
    obj_file_path = f'{output_directory}/closed{x}.obj'

    # Open OBJ file for writing
    with open(obj_file_path, 'w') as obj_file:
        # Write vertices and faces for each cube
        vertex_index = 1
        for j in range(len(row_data)):
            yj = j
            z = row_data[j]

            # Define vertices for the current cube
            vertices = [
                (0, yj, 0), (1, yj, 0), (1, yj + 1, 0), (0, yj + 1, 0),  # Bottom vertices
                (0, yj, z), (1, yj, z), (1, yj + 1, z), (0, yj + 1, z)   # Top vertices
            ]

            # Write vertices to OBJ file
            for vertex in vertices:
                obj_file.write(f"v {' '.join(map(str, vertex))}\n")

            # Define faces for the current cube
            # Bottom face
            obj_file.write(f"f {vertex_index} {vertex_index + 1} {vertex_index + 2} {vertex_index + 3}\n")
            # Top face
            obj_file.write(f"f {vertex_index + 4} {vertex_index + 5} {vertex_index + 6} {vertex_index + 7}\n")
            # Side faces
            obj_file.write(f"f {vertex_index} {vertex_index + 1} {vertex_index + 5} {vertex_index + 4}\n")
            obj_file.write(f"f {vertex_index + 1} {vertex_index + 2} {vertex_index + 6} {vertex_index + 5}\n")
            obj_file.write(f"f {vertex_index + 2} {vertex_index + 3} {vertex_index + 7} {vertex_index + 6}\n")
            obj_file.write(f"f {vertex_index + 3} {vertex_index} {vertex_index + 4} {vertex_index + 7}\n")

            # Increment vertex index for the next cube
            vertex_index += 8
