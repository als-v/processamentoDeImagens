pkg load image

# abre a imagem de entrada e converte para double
img = imread("imagem.jpg");
imgDouble = im2double(img);

# filtro de média 9x9
matriz9x9 = ones(9,9);
filtro = matriz9x9/81;

# aplicação do filtro
filtroMedia = padarray(imgDouble, [4,4], 0);
filtroMedia = filter2(media, imgDouble, 'same');

# borda com zeros
imgPadding = padarray(imgDouble, [4,4], 'replicate');

# replicação da borda
bordaReplicada = filter2(media, imgPadding, 'valid'); 

# filtro de sobel
sobel_1 = [-1, -2, -1; 0, 0, 0; 1, 2, 1];
sobel_2 = [-1, 0, 1; -2, 0, 2; -1, 0, 1];

# replicando os pixels
sobel_padding = padarray(imgDouble, [1,1], 0);

# aplicando os filtros
img_sobel_1 = filter2(sobel_1, sobel_padding, "valid");
img_sobel_2 = filter2(sobel_2, sobel_padding, "valid");

# calcular magnitude
img_sobel_1 = abs(img_sobel_1);
img_sobel_2 = abs(img_sobel_2);
magnitude = img_sobel_1 + img_sobel_2;

# Imagem após filtro de Média com padding de zeros.
figure(1);
imshow(filtroMedia);
title('Imagem após filtro de Média com padding de zeros.');
# QUESTÃO 5:
# Usando o filtro de média, a borda fica mais escura, isso ocorre pois o padding
# de zeros na imagem fazem surgir uma borda da cor da intensidade 0 (preto), nas
# suas linhas e colunas após aplicar o filtro.

# Imagem após filtro de Média com padding replicando os pixels da borda.
figure(2);
imshow(bordaReplicada);
title('Imagem após filtro de Média com padding replicando os pixels da borda.');

# Imagem da magnitude do gradiente após filtros de Sobel.
figure(3);
imshow(magnitude);
title('Imagem da magnitude do gradiente após filtros de Sobel.');