%generates N random training images
clear, close all, clc
N = 10000; %training images
iter = 1;
dim = 128;
load('Efield.mat')
while iter <= N
Enoise = E;
for i = 1:10
    for j = 1:5
        D = abs(Enoise(i,j));
        Enoise(i,j) = Enoise(i,j) + normrnd(0, D/50);
    end
end
P = phantom(Enoise,dim);
P = imrotate(P,randi([0 180]),'crop');
%imagesc(P)
if min(min(P(:)))>-.1
    iter = iter+1;
    scan(:,:,iter) = P;
    %figure, imagesc(P)
end
end
%montage(scan, 'size', [3 3])
save('trainingscans.mat', 'scan');
testscan = scan(:,:,1:10);
save('testscans.mat', 'testscan')