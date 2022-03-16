load('noisy_outputs.mat'); %only has 10 images
load("noisy_inputs.mat");
NNI = zeros(1,128*128,3,2);
realI = zeros(128,128,3);
for i = 1:3
    realI(:,:,i) = reshape(all_img_outputs(:,:,i),128,128);
end

load('net_N20_1212_noisy_LM.mat');
for j = 1:3 %Each Image
        NNI(:,:,j,1) = net(all_img_inputs(:,:,j));
        A = NNI(:,:,j,1);
        fbp_mse(1,j) = mean( (all_img_outputs(:,:,j) - NNI(:,:,j,1)).^2);
end
load('net_N20_12_noisy_LM.mat');
for j = 1:3 %Each Image
        NNI(:,:,j,2) = net(all_img_inputs(:,:,j));
        fbp_mse(2,j) = mean( (all_img_outputs(:,:,j)- NNI(:,:,j,2)).^2);
end

for i = 1:3
    for j = 1:2
        NNimage(:,:,i,j) = reshape(NNI(:,:,i,j),128,128);
    end
end




