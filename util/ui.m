function config = ui
    if isfile('last_config.mat')
        load('last_config.mat', 'config')
        useLastConfig = questdlg(sprintf('Would you like to use the last configuration? Number of circles: %d, Number of trials: %d, Constraints: %s', config.n, config.trails, mat2str(config.cons)),...
              'Detected a recent configuration file',...
              'Yes', 'No','Yes');
        switch useLastConfig
            case 'Yes'
                return
        end
        definput = {num2str(config.n),num2str(config.trails)};

    else
        definput = {'1','50'};
    end
    prompt = {'How many circles?:','How many trials (random initial sets)?'};
    dlgtitle = 'RApDoP Basic Configuration';
    dims = [1 35];
    configChoice = inputdlg(prompt,dlgtitle,dims,definput);
%     disp(str2num(configChoice{2}))
    configntmp = str2num(configChoice{1});
    configtrailstmp = str2num(configChoice{2});
    
    answer = questdlg('Would you like to draw a polygon by mouse or type in coordinates?',...
                      'Getting started with the polygon',...
                      'Draw by mouse', 'Type in coordinates','Draw by mouse');
    
    switch answer
        case 'Draw by mouse'    
            configptstmp = drawPoints;
        case 'Type in numbers'
            prompt = {'x coordinates of vertices (separated by spaces):', 'y coordinates of vertices (separated by spaces):'};
            dlgtitle = 'Polygon vertice';
            dims = [1 50];
            if isfile('last_config.mat')
                load('last_config.mat','config')
                definput1 = mat2str(config.pts(1,:));
                definput2 = mat2str(config.pts(2,:));
                definput = {definput1(2:end-1),definput2(2:end-1)};
            else
                definput = {'0 1 1 0','0 0 1 1'};
            end
            answer = inputdlg(prompt,dlgtitle,dims,definput);
            configptstmp = [str2num(answer{1});str2num(answer{2})];
%             disp(config.pts)
    end
    
    answer = questdlg('Are there any hard distance bounds on circle centers?',...
                  'Constraints',...
                  'No', 'Yes', 'No');
    switch answer
        case 'No constraints'
            configconstmp = [];
        case 'Yes, put constriants'
            prompt = {'Write bounds in the form of [circle1(index) circle2(index) distance(lower bound) distance(upper bound)]; e.g., [1 2 3 4] will limit the distance between centers of circles 1 and 2 to between 3 and 4.'};
            dlgtitle = 'Polygon vertices';
            dims = [5 50];
            if isfile('last_config.mat')
                load('last_config.mat','config')
                definput = {mat2str(config.cons)};
            else
                definput = {'0 1 1 0','0 0 1 1'};
            end
            tmpanswer = inputdlg(prompt,dlgtitle,dims,definput);
            configconstmp = str2num(tmpanswer{1});
    end
    
    config.n = configntmp;
    config.trails = configtrailstmp;
    config.cons = configconstmp;
    config.pts = configptstmp;
end