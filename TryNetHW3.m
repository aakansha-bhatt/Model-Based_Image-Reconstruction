load('net_N20_12_noisy_LM.mat');

load('real_inputs.mat')
y = net(real_img_inputs);
dim=102;
I = reshape(y,dim,[]);
imagesc(I);
%P = reshape(all_img_outputs(:,:,selection),dim,[] );
%fbp_mse = mean( (I(:) - P(:)).^2);

