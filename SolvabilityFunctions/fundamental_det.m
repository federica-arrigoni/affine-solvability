%% Author: Federica Arrigoni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

function F=fundamental_det(P,Q)
% The function computes the fundamental matrix given two cameras
% Input: two 3x4 camera matrices
% Output: a 3x3 fundamental matrix
%
% NOTE: This is the general formula for fundamental matrix given two
% cameras: in the case of affine cameras, it returns an affine
% fundamental matrix, as expected

% Initialize an empty matrix
F=zeros(3);
% Compute the fundamental matrix entrywise
for h=1:3
    for k=1:3
        Pk=P; Pk(k,:)=[];
        Qh=Q; Qh(h,:)=[];
        F(h,k)=(-1)^(h+k)*det([Pk;Qh]);
    end
end

end