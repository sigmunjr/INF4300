function [ glcm ] = GLCM( image, graylevels, dydx )

glcm = zeros(graylevels);
[N M] = size(image);
%Jeg bruker noen overavanserte funksjoner for å regne ut hvor jeg må stoppe
%for å ikke indeksere utenfor bilde. Det eneste de gjør er å legge til så
%man starter på en større indeks hvis x eller y er mindre enn 0 og trekker
%fra på slutten hvis de er større enn 0.
for y=1-dydx(1)*double(dydx(1)<0):N-dydx(1)*double(dydx(1)>0)
    for x=1-dydx(2)*double(dydx(2)<0):M-dydx(2)*double(dydx(2)>0)
        tmpx = image(y+dydx(1),x+dydx(2)); tmpy = image(y,x);
        glcm(tmpy, tmpx) = 1+glcm(tmpy,tmpx);
        
    end
end
glcm = glcm + glcm';
N = N-abs(dydx(1));
M = M-abs(dydx(2));
glcm = (1/(2*N*M)).*glcm;
end





