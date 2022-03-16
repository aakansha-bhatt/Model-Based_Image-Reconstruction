%preload a net you want to use
load('all_inputs.mat')
load('all_outputs.mat') %load to help tell us the MSE
selection = 8;
dim=128;
y = net(all_img_inputs(:,:,selection));
I = reshape(y,dim,[]);
imagesc(I);
P = reshape(all_img_outputs(:,:,selection),dim,[] );
fbp_mse = mean( (I(:) - P(:)).^2);

