%% Author: Gabriele Pedroni
%% Reference: Viewing graph solvability under the affine camera model - 
%% Gabriele Pedroni, Rakshith Madhavan, Federica Arrigoni - CVPR 2026

function [Cams,Funds]=random_affineCams_affineFunds(G)
    % The function generates random affine cameras and corresponding
    % fundamental matrices according to the viewing graph given as input
    % Input: a graph object G representing the viewing graph
    % Output: two three dimensional matrices, the first is a 3x4xn matrix
    % storing all the camera matrices and the second is a 3x3xe matrix
    % containing some of the fundamental matrices between affine cameras
    % n=number of nodes, e=number of edges
    
    % Get a list of all edges, #nodes and #edges from the graph object
    E=G.Edges.EndNodes;
    n=numnodes(G);
    e=numedges(G);

    % Generate random full-rank cameras of the affine form
    Cams=zeros(3,4,n);
    for i=1:n
        P=generateAffine();
        % no need to check the rank, generateAffine() does it
        Cams(:,:,i)=P;
    end

    % Generate noiseless fundamental matrices from cameras
    Funds=zeros(3,3,e);
    for k=1:e
        i=E(k,1); % left node
        j=E(k,2); % right node
        Pi=Cams(:,:,i); % left camera
        Pj=Cams(:,:,j); % right camera

        % This is the general formula for fundamental matrix given two
        % cameras: in the case of affine cameras, it returns an affine
        % fundamental matrix, as expected
        F=fundamental_det(Pi,Pj);
        Funds(:,:,k)=F; 

    end

end