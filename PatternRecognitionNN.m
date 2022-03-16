%use NN function, pattern recognition network needs variables along rows,
%and instances along columns
%close, clear all, clc
load('noisy_inputs.mat');
load('noisy_outputs.mat');
N = 20; %number of training images we want to try
all_img_inputs = all_img_inputs(:,:,1:N);
all_img_outputs = all_img_outputs(:,:,1:N);
M = reshape(all_img_inputs, 8,[]);
M_out = reshape(all_img_outputs, 1, []);
net = patternnet([12],'traingdx','mse'); 
net = train(net,M,M_out);