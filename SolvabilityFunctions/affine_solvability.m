%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

%% TEST for AFFINE solvability
%% We assume the affine and scale ambiguity have been fixed and are
%% already included in the solvability matrix
%% NOTE: this function is meant for small graphs, in order to handle 
%% large-scale problems, please substitute the rank function with sparse 
%% solvers like svds/eigs

function issolvable = affine_solvability(A)
% Input:
% A = adjacency matrix of the viewing graph
% Output:
% issolvable = true if the graph is affine solvable, false otherwise

G=graph(A);

% Simulate camera matrices and compute (noiseless) fundamental matrices
% The affine setup is considered
[Cams,Funds]=random_affineCams_affineFunds(G);

% Compute number of connected components
cc=conncomp(G);
if max(cc)~=1
    disp('Not connected, hence not solvable');
    issolvable=false;
else
    % Create system of equations from skewsymmetric matrix property
    S_direct=affine_solvability_skewSymmMatrix(G, Funds);

    % Compute the rank of S
    r =  rank(full(S_direct));

    % If the matrix is full rank, the viewing graph is solvable
    issolvable =( size(S_direct,2) == r );

end

end