function [outputimage] = focus(data_im, option)

    max_file = size(data_im,1);
    measureBlur = cell(max_file,1);

    %% Calculating measure of Blur
    switch option
        case 1
           % filter=[0 -1 0 ; -1 5 -1 ; 0 -1 0];
            filter = [-1 -4 -1;-4 20 -4;-1 -4 -1];
            for i = 1:max_file
                measureBlur{i,1} = imfilter(mean(data_im{i,1},3),filter,'replicate');
            end
        case 2
            M = 5;
            N = 5;
            mask = ones(M,N);
            for i = 1:max_file
                slidingmean = conv2(mean(data_im{i,1},3), mask/(M*N), 'same');
                measureBlur{i,1} = sqrt( conv2(mean(data_im{i,1},3).^2,mask/(M*N),'same') - slidingmean.^2 );
            end
        case 3 
            for i = 1:max_file
                [Gmag, Gdir] = imgradient(mean(data_im{i,1},3),'intermediatedifference'); %sobel
                measureBlur{i,1} = Gmag;
            end
        case 4
            filter_row=[-1;2;-1];
            filter_col=[-1 2 -1];
            for i = 1:max_file
                tempim=mean(data_im{i,1},3);
                measureBlur{i,1} =abs(imfilter(tempim,filter_row,'replicate'))+abs(imfilter(tempim,filter_col,'replicate'));
            end
        case 5
            for i = 1:max_file
                tempim=mean(data_im{i,1},3);
                tempim=medfilt2(tempim,[3 1],'symmetric');
                % assume periodicity 
                Ir=tempim-0.5*circshift(tempim,2,1)-0.5*circshift(tempim,-2,1);
                tempim=mean(data_im{i,1},3);
                tempim=medfilt2(tempim,[1 3],'symmetric');
                Ic=tempim-0.5*circshift(tempim,2,2)-0.5*circshift(tempim,-2,2);
                 measureBlur{i,1}=Ir.^2+Ic.^2;
            end

        case 6
            M = 3;
            N = 3;
            beta = 0.5;
            alpha = 1;
            mask = ones(M,N);

            for i = 1:max_file
                [Ic, Ir] = gradient(mean(data_im{i,1},3));
                IcSum = conv2(Ic.^2, mask/(M*N), 'same');
                IrSum = conv2(Ir.^2, mask/(M*N), 'same');
                IrIcSum = conv2(Ic.*Ir, mask/(M*N), 'same');
                [rows,cols,ch] = size(data_im{i});
                A = zeros(rows,cols);
                theta = zeros(rows,cols);
                for j = 1:rows
                    for k = 1:cols    
                        C = [ IcSum(j,k) IrIcSum(j,k); IrIcSum(j,k) IrSum(j,k)];
                        [V,D] = eig(C);
                        A(j,k) = D(1,1)-D(2,2);
                        theta(j,k) = atan(V(2,1)/V(1,1));
                    end
                end
                thetaMean = conv2(theta, mask/(M*N), 'same');
                P =  cos(theta-thetaMean);
                measureBlur{i,1} = (P.^beta).*(A.^alpha);
            end




        otherwise
            disp('Incorrect option')
    end


    %% Building final image
    [rows,cols,ch] = size(data_im{i});
    outputimage = (zeros(rows,cols,ch));
    weight = zeros(rows,cols,max_file);
    for k = 1:max_file
        weight(:,:,k) = weight(:,:,k) + measureBlur{k,1};
    end

    weightNorm = zeros(rows,cols,max_file);
    pixel = 0;
    for k = 1:max_file 
        weight(isnan(weight))=0;
        weight((weight)<=1e-10)=0;

        weightNorm(:,:,k) = weight(:,:,k)./sum(weight,3);
        weightNorm(isnan(weightNorm))=1/max_file;
        replaceImage =  weightNorm(:,:,k).*im2double(data_im{k,1});
        replaceImage(isnan(replaceImage)) = 0;
        outputimage(:,:,:) = outputimage(:,:,:) + replaceImage;
        %end
    end
    ana = 0;


