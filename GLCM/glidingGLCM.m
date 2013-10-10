function [ out ] = glidingGLCM( image, fun, dy, dx, windowSize )
    div = 1;
    [N M] = size(image);
    nhalf = int16(floor(windowSize/2));
    out = zeros(N/div-nhalf*2, M/div-nhalf*2);
    %displayGLCM(textures{i}, [3 0 4 2 10], [0 1 0 7 0]);
    %out = zeros(int16(N/div)-nhalf, int16(M/div));
    %size(out)
    for jj=nhalf+1:div:M-nhalf
        for ii=nhalf+1:div:N-nhalf
            imPart = image(ii-nhalf:ii+nhalf, jj-nhalf:jj+nhalf);
            %imPart = histeq(imPart, 16).*((16-1)/256) + 1;
            glcm = GLCM(imPart,16, [dy dx]);
            out(ceil((ii-nhalf)/div),ceil((jj-nhalf)/div)) = fun(glcm);
        end
    end
end

