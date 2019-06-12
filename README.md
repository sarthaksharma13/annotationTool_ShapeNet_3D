# Annotation tool for 2D annotation of the rendered images from ShapeNet


Steps to be followed :

1. Open  annotation_new_junaid.m script.
2. change the startModelIdx and endModelIdx  (on lines 3-4 of the script) accordingly.
3. modify path of keypoint mat name (line-9): mat_name = '<path to shape_net_new folder>/shape_net_new/car_keypoints_mat.mat' 
    [Optionally, you can also give your own name instead of car_keypoints_mat]
4. Run the code

YOU CAN START FROM IDX 101-200; MAKE SURE WE HAVE DIFFERENT VARIETY OF CARS OR OUR MEAN SHAPE
WILL HAVE A BIAS TOWARDS A PARTICULAR MODEL OF THE CAR

Keypoint annotation sequence (it is also displayed in matlab while loading the object):

Keypoint selection sequence: 
	Front side: Right {roof top, mirror, headlight}, Left{ headlight, mirror, roof top}
	Right side: front wheel, rear wheel
 	Back side : Right {rooftop, back light}, Left {back light, rooftop} 
	Left side : rear wheel, front wheel

Commands to toggle different sides of the car:
              f   :  front side of the car
              b  :  rear side of the car
              l   :  left side of the car
              r   :  right side of the car
              n  :  next model (does not saves the annotations; use it for skipping a model)
              +  :  zoom in   (try avoiding this control or if used make sure you zoom out accordingly)
              -   : zoom out  (try avoiding this control or if used make sure you zoom in accordingly)
 [ SPACE ] :  save the annotations and proceed

All the annotations are written in the file car_keypoints_mat (or the name you provided if mat_name changed).

Note: the sequence is reversed while saving. 
