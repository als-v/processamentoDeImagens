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

# filtro notch criado no gimp
filtro = imread('filtro.png');
filtro = im2double(filtro);

# multiplicação do filtro com a transformacao rapida de Fourier
imagemFiltro = imagemRapidaFourier .* filtro;
imagemFiltro = fftshift(imagemFiltro);
imagemFiltro = ifft2(imagemFiltro);
imagemFiltro = real(imagemFiltro);

# mostra apenas a parte superior esquerda
imagemFinal = zeros(M, N);
imagemFinal = imagemFiltro(1:M, 1:N);

imwrite(imagemFinal, 'resultado.png');

figure(3);
imshow(im2uint8(imagemFinal));
title('Multiplicação do filtro com a transformação de fourier.');