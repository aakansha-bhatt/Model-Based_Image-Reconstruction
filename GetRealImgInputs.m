load('brainFDG_projection.mat')
vec = [0:143]*180/144;
dim = 102;
pp = g/23.3564;
    nofilt = iradon(pp,vec);
    nofilt = nofilt - min(nofilt(:));
    %nofilt = nofilt(2:129, 2:129); %recenters it
    fbp_ram = iradon(pp,vec,'ram-lak');
    fbp_ram = fbp_ram - min(fbp_ram(:));
    imagesc(fbp_ram)
    fbp_shepp = iradon(pp,vec,'linear','shepp-logan');
    fbp_shepp = fbp_shepp - min(fbp_shepp(:));
    fbp_cos = iradon(pp,vec,'linear','cosine');
    fbp_cos = fbp_cos - min(fbp_cos(:));
    fbp_hamm = iradon(pp,vec,'linear','Hamming');
    fbp_hamm = fbp_hamm - min(fbp_hamm(:));

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
real_img_inputs(1,:) = reshape(fbp_ram,1,[]);
real_img_inputs(2:8,:) = pixel_inputs;

save('real_inputs.mat', 'real_img_inputs');

