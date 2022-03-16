load('all_outputs.mat'); %only has 10 images
load("all_inputs.mat");
NNI = zeros(1,128*128,3,4);
realI = zeros(128,128,3);
for i = 1:3
    realI(:,:,i) = reshape(all_img_outputs(:,:,i),128,128);
end

load('net_N10_1212.mat');
for j = 1:3 %Each Image
        NNI(:,:,j,1) = net(all_img_inputs(:,:,j));
        A = NNI(:,:,j,1);
        fbp_mse(1,j) = mean( (all_img_outputs(:,:,j) - NNI(:,:,j,1)).^2);
end
load('net_N20_1212_1.mat');
for j = 1:3 %Each Image
        NNI(:,:,j,2) = net(all_img_inputs(:,:,j));
        fbp_mse(2,j) = mean( (all_img_outputs(:,:,j)- NNI(:,:,j,2)).^2);
end
load('net_N2000_12_it72.mat');
for j = 1:3 %Each Image
        NNI(:,:,j,3) = net(all_img_inputs(:,:,j));
        fbp_mse(3,j) = mean( (all_img_outputs(:,:,j) - NNI(:,:,j,3)).^2);
end
load('net_N2000_88_it335.mat');
for j = 1:3 %Each Image
        NNI(:,:,j,4) = net(all_img_inputs(:,:,j));
        fbp_mse(4,j) = mean( (all_img_outputs(:,:,j) - NNI(:,:,j,4)).^2);
end
for i = 1:3
    for j = 1:4
        NNimage(:,:,i,j) = reshape(NNI(:,:,i,j),128,128);
    end
end




