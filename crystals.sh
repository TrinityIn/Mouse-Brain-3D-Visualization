#!/bin/bash

# Define input and output file paths
input_file="/path/to/directory/coordinates_and_volume.txt"
output_file="/path/to/output/crystals.obj"

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

def create_cube_faces(offset, color):
    """
    Create faces for a cube with the given offset and color
    """
    base_index = offset * 8 + 1  # Each cube has 8 vertices, starting from 1
    return [
        (base_index, base_index + 1, base_index + 2, base_index + 3, color),  # Front face
        (base_index + 4, base_index + 7, base_index + 6, base_index + 5, color),  # Back face
        (base_index, base_index + 4, base_index + 5, base_index + 1, color),  # Bottom face
        (base_index + 3, base_index + 2, base_index + 6, base_index + 7, color),  # Top face
        (base_index + 1, base_index + 5, base_index + 6, base_index + 2, color),  # Left face
        (base_index + 4, base_index, base_index + 3, base_index + 7, color)   # Right face
    ]

def get_rainbow_color():
    """
    Generate rainbow colors
    """
    import colorsys
    num_colors = 12  # Number of colors in the rainbow
    colors = []
    for i in range(num_colors):
        hue = i / num_colors
        r, g, b = colorsys.hsv_to_rgb(hue, 1.0, 1.0)
        colors.append((r, g, b))
    return colors

with open('$input_file', 'r') as f:
    lines = f.readlines()

with open('$output_file', 'w') as f:
    # Write header
    f.write("g Cubes\n")

    # Initialize vertex offset
    vertex_offset = 0

    # Get rainbow colors
    rainbow_colors = get_rainbow_color()

    # Iterate through each line in the input file
    for i, line in enumerate(lines):
        # Extract coordinates
        parts = line.split(",")
        x = int(parts[1].split("(")[1]) / 2  # Scale down x coordinate
        y = int(parts[2]) / 2                # Scale down y coordinate
        z = int(parts[3].split(")")[0]) / 2  # Scale down z coordinate

        # Define scale factor
        scale = 20  # Adjust the scale factor as needed

        # Create vertices for the cube
        vertices = create_cube_vertex(x, y, z, scale)

        # Get rainbow color for current cube
        color = rainbow_colors[i % len(rainbow_colors)]

        # Write vertices to file
        for vertex in vertices:
            f.write("v {} {} {}\n".format(vertex[0], vertex[1], vertex[2]))

        # Create faces for the cube
        faces = create_cube_faces(vertex_offset, i + 1)  # Use cube index as color

        # Write faces to file
        for face in faces:
            f.write("f {} {} {} {} {}\n".format(face[0], face[1], face[2], face[3], face[4]))

        # Update vertex offset for next cube
        vertex_offset += 1

print("OBJ file created: $output_file")
EOF
