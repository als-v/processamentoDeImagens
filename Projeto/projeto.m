pkg load image;

# abrir a imagem
imagem = imread('imagem.jpg');

# rgb para hsv
imagem = im2double(rgb2hsv(imagem));

# restrinjo ao 3 array
imagem = imagem(:,:,3);

# tamanho da imagem
[M, N] = size(imagem);
P = 2*M;
Q = 2*N;

# transformada de fourier
imagemRapidaFourier = fft2(imagem, P, Q);
imagemRapidaFourier = fftshift(imagemRapidaFourier);
espectro = uint8(abs(imagemRapidaFourier));

figure(1);
imshow(espectro);
title('Imagem da transformação rápida de Fourier.');