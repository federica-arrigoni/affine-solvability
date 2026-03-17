
%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

function A = graphWithArticulation(n)
% Create a connected graph with n nodes and a guaranteed articulation point

if n < 4
    error('Need at least 4 nodes');
end

% Step 1: Partition sizes
a = randi([1, n-2]);   % ensure at least 1 node in each subgraph
b = n - 1 - a;

% Node layout:
% [1..a] -> subgraph G1
% [a+1..a+b] -> subgraph G2
% [n] -> bridge node

A = zeros(n);

% Step 2: Create two random connected subgraphs (trees)
A(1:a, 1:a) = generateAdjMatrix(a);
A(a+1:a+b, a+1:a+b) = generateAdjMatrix(b);

% Step 3: Connect articulation point (node n) to each subgraph
connect1 = randi([1 a]);
connect2 = randi([a+1 a+b]);

A(connect1, n) = 1; A(n, connect1) = 1;
A(connect2, n) = 1; A(n, connect2) = 1;

end