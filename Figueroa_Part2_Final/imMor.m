function morIma = imMor(Ima, im, names)% Function to peform morphological operations% Closing also includes the imfill operationif(not(isa(Ima, 'logical')))    morIma = Ima;    disp('The image is not a binary image, it cannot be operated!!')    returnendc = 'y';while(c == 'y')    disp('');    disp('Which morpholigcal operation would you like to perform')    disp(' [0] Cancel')    disp(' [1] Dilation')    disp(' [2] Erosion')    disp(' [3] Closing - with options')    disp(' [4] Opening - with options ');    disp('');    ope = input('Which morpholigcal operation would you like to perform? [1...4]: ');    disp('');        switch ope        case 0            morIma = Ima;            break                    case 1            %Dilation            se = imSE;            morIma = imdilate(Ima, se, 'same');            morOpe = 'Dilation';            disp('Ok!')            viewImage(morIma, im, names, 8)            title(['Morphologically Operated Image: ', morOpe]);        case 2            %Erosion            se = imSE;            morIma = imerode(Ima, se, 'same');            morOpe = 'Erosion';            disp('Ok!')            viewImage(morIma, im, names, 8)            title(['Morphologically Operated Image: ', morOpe]);        case 3            %Closing            morIma = closeIm(Ima, im, names);            disp('Ok!')                    case 4            %Opening            morIma = openIm(Ima, im, names);            disp('Ok!')    end        while(true)        c = lower(input('Would you like to try a different operation? y/n: ','s'));        if(c == 'y')            break        else            msgbox('You are now working with a morphologically operated image!!', 'modal');            break        end    end    endendfunction se = imSEdisp('Structuring Elements')disp(' [1] Diamond')disp(' [2] Disk')disp(' [3] Octagon')disp(' [4] Rectangle')disp(' [5] Square')disp(' [6] Arbitrary')disp('');SE = input('What type of structuring element would you like to use? [1...6]: ');switch SE    case 1        R = input('Radius of the shape? ');        se = strel('diamond', R);        seN = 'Diamond';    case 2        R = input('Radius of the shape? ');        se = strel('disk', R, 0);        seN = 'Disk';    case 3        R = input('Radius of the shape? (multiple of 3) ');        se = strel('Octagon', R);        seN = 'Octagon';    case 4        MN = input('Size of the shape [M N]? ');        se = strel('rectangle', MN);        seN = 'Rectangle';    case 5        MN = input('Size of the shape? ');        se = strel('square', MN);        seN = 'Square';    case 6        nhood = input('Especify the shape: ');        se = strel('arbitrary', nhood);        seN = 'Arbitrary';endfigure(7)spy(getnhood(se), 'b.', 10); grid on;title(['Structuring Element: ', seN])endfunction morIma = closeIm(Ima, im, names)%Closing functiondisp('Options - closing also includes the operation imfill')disp(' [1] Fix value of SE ')disp(' [2] Range of value for SE = disk')disp('');op = input('What option you like to perfomr? [1...2]: ');switch op    case 1        se = imSE;        morIma = imfill(imclose(Ima, se),'holes');        viewImage(morIma,im,names, 8);        morOpe = 'Closing';        title(['Morphologically Operated Image: ', morOpe]);    case 2        minLevel = input('What is the min size you want to use? ');        maxLevel = input('What is the max size you want to use? ');        stepLevel = input('What is the step value? ');        disp('');        for s = minLevel:stepLevel:maxLevel            se = strel('disk', s, 0);            figure(7)            spy(getnhood(se), 'b.', 10); grid on;            title(['Structuring Element: ', 'disk'])            disp(['s= ' num2str(s) '']);            morIma = imfill(imclose(Ima, se), 'holes');            viewImage(morIma,im,names, 8);            morOpe = 'Closing';            title(['Morphologically Operated Image: ', morOpe ' s= ', num2str(s)]);            disp('Press any key to continue')            pause        endendendfunction morIma = openIm(Ima, im, names)%Opening functiondisp('Options')disp(' [1] Fix value of SE ')disp(' [2] Range of value for SE = disk')disp('');op = input('What option you like to perfomr? [1...2]: ');switch op    case 1        se = imSE;        morIma = imopen(Ima, se);        viewImage(morIma,im,names, 8);        morOpe = 'Opening';        title(['Morphologically Operated Image: ', morOpe]);    case 2        minLevel = input('What is the min size you want to use? ');        maxLevel = input('What is the max size you want to use? ');        stepLevel = input('What is the step value? ');        disp('');        for s = minLevel:stepLevel:maxLevel            se = strel('disk', s, 0);            figure(7)            spy(getnhood(se), 'b.', 10); grid on;            title(['Structuring Element: ', 'disk'])            disp(['s= ' num2str(s) '']);            morIma = imopen(Ima, se);            viewImage(morIma,im,names, 8);            morOpe = 'Opening';            title(['Morphologically Operated Image: ', morOpe ' s= ', num2str(s)]);            disp('Press any key to continue')            pause        endendend