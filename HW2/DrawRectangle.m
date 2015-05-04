function [] = DrawRectangle(maxima,image,template)
%%According to the maxima point, draw red rectangle into the image to mark
%%the dectection result
figure;
imshow(image);
hold on;
%plot the rectangle
[templateHeight,templateWidth] = size(template);
[y,x] = size(maxima);
for i = 1:x
   for j = 1:y
      if maxima(j,i) == 1 
          rectangle('Position',[i - templateWidth/2,j - templateHeight/2,templateWidth,templateHeight],'LineWidth',1,'EdgeColor','g');
      end
   end
end
end