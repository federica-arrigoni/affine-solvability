%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

function S=affine_solvability_skewSymmMatrix(G, Funds)
% Creates a system of the shape Ax=b where x is a vector using as unknowns
% all the parameters of all the camera matrices; this matlab function builds
% the matrix A, then builds a matrix B containing the 12 equations used to
% fix the global ambiguity and then stacks the two matrices to form the
% matrix of coefficients S, which is returned as output. According to
% theory, a viewing graph is solvable if and only if such matrix S is full rank.  
% Input: a viewing graph G and the 3x3xe matrix containing all fundamental
% matrices, where e is the number of edges
% Output: finite solvability matrix S

%% Properties of the graph
n=numnodes(G); % number of nodes in input graph
m=numedges(G); % number of edges in input graph
E=G.Edges.EndNodes; % list of edges in the graph

% We will fix an entire camera and the first row of another camera in order
% to fix the global AFFINE ambiguity 
% Since we want the two cameras to be given and connected, we set node1 and
% node2 as the first two nodes connected in the list of edges (this is
% actually not required for solvability testing, but useful for possibly
% developing an algorithm to extract maximal components in the future)
node1=E(1,1);
node2=E(1,2);

%% Build the affine solvability matrix

nEq = 4*m; % number of equations
A = spalloc(nEq,8*n, nEq*8); % allocate space for a sparse matrix

for k=1:m % for all the edges ...

    % let us consider edge k in the input graph
    i=E(k,1); % left node
    j=E(k,2); % right node

    F=Funds(:,:,k); % fundamental matrix

    % Create the blocks containing the coefficients of the linear equations
    % coming from the skewsymmetric matrix condition
    [B2, B1]=create_blocks(F, i, j);

    % Insert the blocks at the right location in the matrix
    A(k*4-3:k*4, 8*(i-1)+1:8*i)=B1;
    A(k*4-3:k*4, 8*(j-1)+1:8*j)=B2;

end

%% fix projective ambiguity
B=spalloc(12,8*n,12); % allocate space for a sparse matrix

% fix node1 (8 parameters)
B(1:8,8*node1-7:8*node1)=speye(8);

% fix 4 parameters of node 2 (4 parameters)
ind=[8*node2-7:8*node2-5 8*node2-1];
B(9:12,ind)=speye(4); % Fixing 1st row in the second camera

%% Append matrices
S=[A;B];

end