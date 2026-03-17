
%% DEMO to test affine solvability on small synthetic cases

clc, clear, close all
addpath(genpath('./'))

%% Graph generation

% % Graphs analyzed by Levi&Werman
% A=generateCrazyGraphs('4g5'); n=size(A,1);
% A=generateCrazyGraphs('5g6'); n=size(A,1);
% A=generateCrazyGraphs('6g8'); n=size(A,1);

% % Graph with an articulation point
% n=20; A=generateCrazyGraphs('Articulation point',n);

% Random graph
n=20; % nodes
fraction_edges=0.2;
A=rand(n)<fraction_edges;
A=triu(A,1); A=A+A';

cc=conncomp(graph(A)); % ensure connectivity
while(max(cc)~=1)
    A=rand(n)<fraction_edges;
    A=triu(A,1); A=A+A';
    cc=conncomp(graph(A));
end

%% Plot graph

G=graph(A);
figure, plot(G)

%% Check affine solvability - rank computation

disp('----------------------------------------------------------------')
isAffinesolvable = affine_solvability(A);
disp(['Our approach with rank - Is the graph affine solvable? ' num2str(isAffinesolvable)])
disp(' ')
disp('----------------------------------------------------------------')

%% Check affine solvability - sparse solver 

isAffinesolvable = sparse_affine_solvability(A,1e-6);
disp(' ')
disp(['Our approach with eigs - Is the graph affine solvable? ' num2str(isAffinesolvable)])
disp(' ')
disp('----------------------------------------------------------------')

% IMPORTANT NOTE: the threshold has a significant impact
% A wrong threshold might result in an unreliable solvability output
% The rank computation is preferred for small-scale problems

%% Check 2D parallel rigidity 

rigidity2D = ParallelRigidityTest(A,2);
disp(['Is the graph 2D parallel rigid? ' num2str(rigidity2D)])
disp(' ')
disp('----------------------------------------------------------------')

%% Check 3D parallel rigidity = calibrated solvability

rigidity3D = ParallelRigidityTest(A,3);
disp(['Is the graph 3D parallel rigid? ' num2str(rigidity3D)])
disp(' ')
disp('----------------------------------------------------------------')




