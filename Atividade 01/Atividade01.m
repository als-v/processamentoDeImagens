# pacote necessario
pkg load image;

# abrir a imagem
einstein = imread("imagem.jpg");

# função imhist retorna o histograma e os niveisIntensidade
[histograma, niveisIntensidade] = imhist(einstein);

# função size retorna as linhas e colunas de uma imagem
[linhas, colunas] = size(einstein);

# crio uma nova imagem preenchida com zeros
einsteinEqualizado = zeros(linhas, colunas, "uint8");

# tamanho total da imagem
tamanhoTotal = linhas*colunas;

# variavel para o calculo do pr
pr = []

for i = 1:256
  # divido o valor do histograma pelo tamanho total da imagem
 pr(i) = histograma(i)/tamanhoTotal; 
endfor

# variavel para o calculo do s
s = []

for i = 1:256
  aux = 0;
  
  # somatoria dos valores do pr
  for j = 1:i
    aux = aux + pr(j);
  endfor
  
  # ao final multiplico pela intensidade máxima, e arredondo o valor
  s(i) = round(aux * 255);
endfor

# passagem dos valores para a nova imagem
for i = 1:linhas
  for j = 1:colunas
    # para cada posição da imagem inicial, eu vejo seu novo valor equalizado
    einsteinEqualizado(i, j) = s(einstein(i ,j));
  endfor
endfor

# salvo a imagem
imwrite(einsteinEqualizado, "result.jpg");

# mostro a imagem equalizada
figure(1);
imshow(einsteinEqualizado);

# mostro o histograma da imagem normalizada
figure(2);
plot(niveisIntensidade, s);