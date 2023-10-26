%% Load the maze image as a binary image
maze_image = imread('regional_Detection.jpeg'); 
maze_binary = maze_image;

%% Calculate the branching factor
% tells how many branches are connected at each junction in the maze 
[row, col] = size(maze_binary);

branching_factor = 0;

for r = 2:row-1
    for c = 2:col-1
        % goes throgh each pixel in the maze image to analyze junctions
        % ignores the boundary !!!! 
        if maze_binary(r, c) == 0

            % if true , examines the near ones
            neighbors = maze_binary(r-1:r+1, c-1:c+1);

            %exclude the current cell
            % count the number of neigboring cells that are part of the
            % path
            path_count = sum(neighbors(:)) - 1; 

            % if pt > 2 , then it's a confirmed junction
            if path_count > 2
                branching_factor = branching_factor + path_count - 2;
            end
        end
    end
end

% Calculate the average branching factor
if branching_factor > 0
    branching_factor = branching_factor / nnz(maze_binary);
    % nnz --> number of non zero elements 
end

% Display the branching factor
fprintf('Branching factor: %.2f\n', branching_factor);
