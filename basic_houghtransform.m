img = rgb2gray(imread('corridor.png'));
BW = edge(img);
[N M] = size(img);

%Making the range of rho and teta values
rho_range = ceil(sqrt((N-1)^2 + (M-1)^2));
R = -rho_range:rho_range;
%if the teta range went up to 90, we would vote for the same line twise.
T = -90:89;

%Making the H, the same direction as matlab would, so I can use the other
%built in functions
H = zeros(ceil(rho_range)*2, length(teta_range));

%OBS: slow
for i=1:N
    for j=1:M
        if BW(i,j)
            for teta=teta_range
                rho = j*cosd(teta) + i*sind(teta);
                idx_rho = round(rho)+rho_range;
                idx_teta = teta + 91;
                H(idx_rho, idx_teta) = H(idx_rho, idx_teta)+1;
            end
        end
    end
end
imshow(H,[]);

%%Using example code from:
%%http://www.mathworks.se/help/images/ref/houghlines.html to plot the lines
P  = houghpeaks(H,10,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(BW,T,R,P,'FillGap',8,'MinLength',7);
            
figure, imshow(img), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
   plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

% highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','blue');