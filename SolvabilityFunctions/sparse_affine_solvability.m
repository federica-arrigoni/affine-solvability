%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model -
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

%% TEST for AFFINE solvability
%% We assume the affine and scale ambiguity have been fixed and are
%% already included in the solvability matrix
%% NOTE: this function is meant for large-scale problems, please substitute
%% eigs with the rank function for small-scale problems

function issolvable = sparse_affine_solvability(A,tol)
% Input:
% A = adjacency matrix of the viewing graph
% Output:
% issolvable = true if the graph is affine solvable, false otherwise
% tol = threshold used to establish full rank with eigs
% The default tolerance is 1e-10;

% default tol. Formula taken from SuiteSparseQR (similar to Matlab's rank)
% tol = max(m,n)*eps(normest(S_direct,1e-4));
if nargin<2
    tol=1e-10;
end

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

    disp('Computing the smallest eigenvalue with eigs...')
    M=S_direct'*S_direct;
    %assert(issparse(M));
   
    lambda = eigs(M,1,tol,'Display',true); 
    issolvable=lambda(end)>tol;

end

end