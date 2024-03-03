
#!/bin/bash

# Define input and output file paths
input_file="/path/to/directory/coordinates_and_volume.txt"
output_file="/path/to/directory/cube_brain.obj"

# Check if the Python interpreter is available
if ! command -v python3 &>/dev/null; then
    echo "Error: Python 3 is not installed. Please install Python 3 to run this script."
    exit 1
fi

# Execute the Python script
python3 <<EOF
def create_cube_vertex(x, y, z, scale):
    """
    Create vertices for a cube centered at (x, y, z)
    """
    vertices = [
        (x - scale / 2, y - scale / 2, z + scale / 2),  # Front bottom left
        (x + scale / 2, y - scale / 2, z + scale / 2),  # Front bottom right
        (x + scale / 2, y + scale / 2, z + scale / 2),  # Front top right
        (x - scale / 2, y + scale / 2, z + scale / 2),  # Front top left
        (x - scale / 2, y - scale / 2, z - scale / 2),  # Back bottom left
        (x + scale / 2, y - scale / 2, z - scale / 2),  # Back bottom right
        (x + scale / 2, y + scale / 2, z - scale / 2),  # Back top right
        (x - scale / 2, y + scale / 2, z - scale / 2)   # Back top left
    ]
    return vertices

def create_cube_faces(offset):
    """
    Create faces for a cube with the given offset
    """
    base_index = offset * 8 + 1  # Each cube has 8 vertices, starting from 1
    return [
        (base_index, base_index + 1, base_index + 2, base_index + 3),  # Front face
        (base_index + 4, base_index + 7, base_index + 6, base_index + 5),  # Back face
        (base_index, base_index + 4, base_index + 5, base_index + 1),  # Bottom face
        (base_index + 3, base_index + 2, base_index + 6, base_index + 7),  # Top face
        (base_index + 1, base_index + 5, base_index + 6, base_index + 2),  # Left face
        (base_index + 4, base_index, base_index + 3, base_index + 7)   # Right face
    ]

with open('$input_file', 'r') as f:
    lines = f.readlines()

with open('$output_file', 'w') as f:
    # Write header
    f.write("g Cubes\n")

    # Initialize vertex offset
    vertex_offset = 0

    # Iterate through each line in the input file
    for line in lines:
        # Extract coordinates
        parts = line.split(",")
        # Define distance between points
        distance = 10  # Adjust the distance as needed

        # Calculate scaled coordinates
        x = int(parts[1].split("(")[1]) / distance
        y = int(parts[2]) / distance
        z = int(parts[3].split(")")[0]) / distance


        # Define scale factor
        scale = 20  # Adjust the scale factor as needed

        # Create vertices for the cube
        vertices = create_cube_vertex(x, y, z, scale)

        # Write vertices to file
        for vertex in vertices:
            f.write("v {} {} {}\n".format(vertex[0], vertex[1], vertex[2]))

        # Create faces for the cube
        faces = create_cube_faces(vertex_offset)

        # Write faces to file
        for face in faces:
            f.write("f {} {} {} {}\n".format(face[0], face[1], face[2], face[3]))

        # Update vertex offset for next cube
        vertex_offset += 1

print("OBJ file created: $output_file")
EOF
