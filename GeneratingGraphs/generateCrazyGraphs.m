%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

% This function generated popular graphs studied by Levi & Werman:
% "The viewing graph - CVPR 2003"
% This function also simulates a graph with 1 articulation point 
% (in this case, the number of nodes must be given as input) 

function A=generateCrazyGraphs(method, n)
    if(strcmp(method,'4g5')==0 && strcmp(method,'5g6')==0 && strcmp(method,'6g8')==0 && strcmp(method,'Articulation point')==0)
        error('Method given as input not recognized. Please specify a valid method')
    end
    if nargin<2
        if(strcmp(method,'4g5'))
            A = [[0, 1, 1, 1];
                [1, 0, 1, 0];
                [1, 1, 0, 1];
                [1, 0, 1, 0]];
        end
        if(strcmp(method,'5g6'))
            A = [[0, 1, 0, 1, 1];
                [1, 0, 1, 0, 0];
                [0, 1, 0, 1, 1];
                [1, 0, 1, 0, 0];
                [1, 0, 1, 0, 0]];
        end
        if(strcmp(method,'6g8'))
            A = [[0, 1, 0, 1, 0, 0];
                [1, 0, 1, 0, 1, 0];
                [0, 1, 0, 1, 1, 0];
                [1, 0, 1, 0, 0, 1];
                [0, 1, 1, 0, 0, 1];
                [0, 0, 0, 1, 1, 0]];
        end
    else
        if(strcmp(method,'Articulation point'))
            % Generate a graph with n nodes and an articulation point
            A=graphWithArticulation(n);
        end
    end
end