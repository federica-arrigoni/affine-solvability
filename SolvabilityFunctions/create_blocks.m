%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

function [B1, B2]=create_blocks(F, left_cam_index, right_cam_index)
% In order to create the matrix of coefficients, we have to store the
% equations coming from the fundamental matrices in the right location.
% This can be simplified by writing the equations in blocks (since the
% coefficients regarding a certain camera are always going to be localized
% in the same area) and then place the block in the right location. 
% This function creates the blocks.
% Input: Fundamental matrix between camera i and j, and indexes of the two
% cameras
% Output: B1 and B2, 4x8 matrices

% Initialize block matrices
B1=zeros(4, 8);
B2=zeros(4, 8);

% NOTE: the left/right camera indexes are not needed here but useful for
% debugging

% Creation of first block
B1(1, 1)=F(1,3);
B1(1, 4)=F(2,3);
B1(2, 2)=F(1,3);
B1(2, 5)=F(2,3);
B1(3, 3)=F(1,3);
B1(3, 6)=F(2,3);
B1(4, 7)=F(1,3);
B1(4, 8)=F(2,3);

% Creation of second block
B2(1, 1)=F(3,1);
B2(1, 4)=F(3,2);
B2(2, 2)=F(3,1);
B2(2, 5)=F(3,2);
B2(3, 3)=F(3,1);
B2(3, 6)=F(3,2);
B2(4, 7)=F(3,1);
B2(4, 8)=F(3,2);

end