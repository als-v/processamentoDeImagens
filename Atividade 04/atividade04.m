pkg load image;

# abrir a imagem
imagem = imread('imagem.png');

# conversao para double
imagem = im2double(imagem);

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

# salvo o espectro em um novo arquivo
imwrite(espectro, 'espectro.png');

# filtro de passa baixa
matriz = ones(P, Q);

# passo por toda matriz 


figure(2);
imshow(matriz);
title('Filtro notch.');
