close, clc, clear all
load('trainingscans.mat');
N = 20; %number of samples we wish to make
angles = 60; %measure less angles to make a blurrier image
vec = [0:(angles-1)]*180/(angles-1);
scan = scan(:,:,1:N);
dim = 128;
all_img_inputs = zeros(8,dim*dim,N);
all_img_outputs = zeros(1,dim*dim,N);
for i = 1:N
    pp = radon(scan(:,:,i),vec);

    ppnoise = zeros(size(pp));
    ppnoise = imnoise(ppnoise,'gaussian',0,1);   
    pp = pp + ppnoise;

    nofilt = iradon(pp,vec);
    nofilt = nofilt(2:129, 2:129); %recenters it
    fbp_ram = iradon(pp,vec,'linear','ram-lak',1,dim);
    fbp_shepp = iradon(pp,vec,'linear','shepp-logan',1,dim);
    fbp_cos = iradon(pp,vec,'linear','cosine',1,dim);
    fbp_hamm = iradon(pp,vec,'linear','Hamming',1,dim);
    %created the projections using various filters, now we will collect the
    %input variables for the NN

    Ker = [0, -.25, 0;
    -.25, 1, -.25;
    0, -.25, 0];
    %simple convolution kernel for each pixel
    conv_nofilt = conv2(nofilt, Ker, 'same');
    conv_ram = conv2(fbp_ram, Ker, 'same');
    conv_shepp = conv2(fbp_shepp, Ker, 'same');
    conv_cos = conv2(fbp_cos, Ker, 'same');
    conv_hamm = conv2(fbp_hamm, Ker, 'same'); 

    %reshaping
    I_nofilt = reshape(nofilt, 1, []);
    I_conv_nofilt = reshape(conv_nofilt, 1, []);
    I_conv_ram = reshape(conv_ram, 1, []);
    I_conv_shepp = reshape(conv_shepp, 1, []);
    I_conv_cos = reshape(conv_cos, 1, []);
    I_conv_hamm = reshape(conv_hamm, 1, []);

    J = dim*dim; %how many pixels are in the image
    pixel_inputs = zeros(7,J); %setting up array
    maxval = max(nofilt(:)); %largest value read from a nofilter iradon
    minval = max(nofilt(:));
    for j = 1:J
        x1 = maxval-I_nofilt(j); 
        x2 = I_nofilt(j)-minval;
        x3 = I_conv_nofilt(j);
        x4 = I_conv_ram(j);
        x5 = I_conv_shepp(j);
        x6 = I_conv_cos(j);
        x7 = I_conv_hamm(j);
        pixel_inputs(:,j) = [x1 x2 x3 x4 x5 x6 x7]';
    end
all_img_inputs(1,:,i) = reshape(fbp_ram,1,[]);
all_img_inputs(2:8,:,i) = pixel_inputs;
all_img_outputs(:,:,i) = reshape(scan(:,:,i), 1, []);
end
save('noisy_inputs.mat', 'all_img_inputs');
save('noisy_outputs.mat', 'all_img_outputs');
