%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026


function A = generateAdjMatrix(n)
    % The function generates a random graph with n vertices
    % and at least 2n-3 edges. The graph is not necessarily 2-connected
    % Input: n - Number of vertices in the graph (must be >= 3)
    % Output: A - n×n adjacency matrix of a graph
    
    % Initialize adjacency matrix with zeros and a counter for edges
    A = zeros(n, n);
    edgeCount = 0;

    % Set threshold
    minEdges = (11*n-15)/7;
    e = randi([0, n*(n-1)/2]);
    
    % If the random integer used as number of edges is below the minimum
    % number that a viewing graph has to posess to be solvable, then we use
    % the minimum
    if e < minEdges
        e = ceil(minEdges);
    end
    
    % Add more random edges until we have at least 2n-3 edges
    while edgeCount < e
        % Pick two random vertices
        i = randi(n);
        j = randi(n);
        
        % Ensure they are different and not already connected
        if i ~= j && A(i, j) == 0
            A(i, j) = 1;
            A(j, i) = 1;  % Make it symmetric
            edgeCount = edgeCount + 1;
        end
    end

end