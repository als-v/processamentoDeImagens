pkg load image;

# abrir a imagem
imagemEntrada = imread('imagem.jpg');

# rgb para hsv
imagemConvertida = im2double(rgb2hsv(imagemEntrada));

# restrinjo a imagem
imagem = imagemConvertida(:,:,3);

# tamanho da imagem
[M, N] = size(imagem);
P = 2*M;
Q = 2*N;

# transformada de fourier
imagemRapidaFourier = fft2(imagem, P, Q);
imagemRapidaFourier = fftshift(imagemRapidaFourier);
espectro = uint8(abs(imagemRapidaFourier));

## para livrar o codigo de executar o filtro toda vez, salvei o resultado dessa 
## interação como a imagem 'filtro.png', para usar novamente
#d0 = 175;
#filtro = zeros(P, Q);

#for u = 1:P
#  for v = 1:Q
#    Duv = (((u - P/2)^2) + ((v - Q/2)^2))^(1/2);
#    filtro(u, v) = e ^ ((-Duv^2)/(2*(d0^2)));
#  endfor
#endfor

# filtro de passa baixa
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

# imagem recebe o resultado
imagemConvertida(:,:,3) = imagemFinal;
imagemConvertida = hsv2rgb(imagemConvertida);

# ajuste RGB para melhor contraste
imagemConvertida = imadjust(imagemConvertida,[.03 .03 .03; .85 .9 .7],[]);

# salvo a imagem
imwrite(imagemConvertida, 'resultado.png');

figure(1);
imshow(imagemConvertida);
title('Resultado final.');