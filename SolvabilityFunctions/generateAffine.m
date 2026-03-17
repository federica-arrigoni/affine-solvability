%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

function P = generateAffine()
    % The function generates a random affine camera matrix. Some controls
    % are implemented to make sure that the matrix is valid; no scaling is
    % applied on the "free" entries, so they're all between 0 and 1
    % Input: /
    % Output: a 3x4 matrix representing a valid affine camera matrix

    % Create a 2×3 matrix, in the literature is called M
    M = rand(2, 3);
    
    % Check on rank of M
    while(rank(M)<2)
        M = rand(2,3);
    end
    
    % Create translation vector t
    t = rand(2, 1); 
    
    % Combine to form a 2×4 "pre-affine matrix"
    P = [M, t];
    
    % Add the [0, 0, 0, 1] row
    P = [P; [0, 0, 0, 1]];

end