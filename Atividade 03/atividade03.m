pkg load image;

# abrir a imagem
imagem = imread('imagem.png');

# conversao para double
imagem = im2double(imagem);

# tamanho da imagem
[M, N] = size(imagem);
P = 2*M;
Q = 2*N;

# a transformada será o dobro da imagem original, com
# 3/4 da imagem preenchida com 0's, formando uma imagem
# preta ao redor.
imagemRapidaFourier = fft2(imagem, P, Q);
imagemRapidaFourier = fftshift(imagemRapidaFourier);

figure(1);
imshow(uint8(abs(imagemRapidaFourier)));
title('Imagem da transformação rápida de Fourier.');

# filtro de passa baixa
d0 = 20;
filtro = zeros(P, Q);

for u = 1:P
  for v = 1:Q
    Duv = (((u - P/2)^2) + ((v - Q/2)^2))^(1/2);
    filtro(u, v) = e ^ ((-Duv^2)/(2*(d0^2)));
  endfor
endfor
  
figure(2);
imshow(filtro);
title('Filtro passa-baixa gaussiano.');

# multiplicação do filtro com a transformacao rapida de Fourier
imagemFiltro = imagemRapidaFourier.*filtro;
imagemFiltro = fftshift(imagemFiltro);
imagemFiltro = ifft2(imagemFiltro);
imagemFiltro = real(imagemFiltro);

# mostra apenas a parte superior esquerda
imagemFinal = zeros(M, N);
imagemFinal = imagemFiltro(1:M, 1:N);

figure(3);
imshow(im2uint8(imagemFinal));
title('Multiplicação do filtro com a transformação rápida de fourier.');
