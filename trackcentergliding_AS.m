%% This dcript is written by Abhishek Shrivastava

clear variables
clc
close all
vidObj = VideoReader('FJ_crop.avi'); % reads the video file
data = read(vidObj, Inf);  % reads the last frame of video file
numFrames = vidObj.NumberOfFrames; % determines the number of frmaes in the video

counter = 0;
 for ii = 1: floor(numFrames/2.1): numFrames
     image = read(vidObj, ii); 
     A=double(image);
         
     if ii == 1
         imagesc(A)
         title('Frame1');
         
         prompt1 = 'What is the threshold? ';
         T = input(prompt1);
         A(A<T) = 0;
     end
         A(A<T) = 0;
         counter = counter +1;
         figure(2)
         subplot(1,3,counter)
         imshow(A)
        
         prompt2 = 'if happy with threshold press 1 else 0';
         Happy = input(prompt2);
    
     if Happy == 0
         disp('Run again and select the correct threshold')
         break
     end
    
 end
 
  if Happy == 1
      
      S1 = zeros(numFrames,1);
      
      for ki = 1: numFrames
         
  image = read(vidObj, ki); 
%         A=rgb2gray(image);
%         B = im2bw(A);
%         stats = regionprops(B,'Area');
%         area = cat(1,stats.Area);
%         area2(ki) = area;
%           
        %imageData = rgb2gray(image);
        imageData = double(image);
        imageData(imageData<T) = 0;
             close all
        [centerx, centery]= Fittingelipse1(imageData,T);
		 
        axis equal
        S= [centerx; centery];
        S1(ki,1:2)=S;
%  
        hold on
        clc
      end
  end
  figure(3)
  scatter(S1(:,1),S1(:,2))
xlabel('center x')
ylabel('center y')
  hold on
scatter(S1(1,1),S1(1,2),'* g')
scatter(S1(end,1),S1(end,2),'* r')   
axis equal
  

