%%  2.1 Contrast Stretching

% a) & b) Load and display the original image in one figure
Pc = imread('img/mrt-train.jpg');
whos Pc
figure;
imshow(Pc);  
title('Original Image (RGB)');  

% Convert to grayscale and display in another figure
P = rgb2gray(Pc); 
whos P
figure;  
imshow(P);  
title('Grayscale Image');  

% c) Check the minimum and maximum intensity values
min_intensity = min(P(:));  
max_intensity = max(P(:));  
fprintf('Minimum Intensity: %d\n', min_intensity);
fprintf('Maximum Intensity: %d\n', max_intensity);

% d) & e) Perform contrast stretching

% Convert the grayscale image to double for computation
P_double = double(P);

% Convert min and max intensities to double
min_intensity_double = double(min_intensity);
max_intensity_double = double(max_intensity);

% Apply contrast stretching
P_stretched = (P_double - min_intensity_double) * (255 / (max_intensity_double - min_intensity_double));

% Convert the result back to uint8 format
P2 = uint8(P_stretched);

% Verify that the minimum and maximum intensities are now 0 and 255
min_new = min(P2(:));
max_new = max(P2(:));
fprintf('New Minimum Intensity: %d\n', min_new);
fprintf('New Maximum Intensity: %d\n', max_new);

% Display the contrast-stretched image
figure;
imshow(P2);
title('Grayscale Image (After Contrast Stretching)');

%% 2.2 Histogram Equalization

% a) Display the intensity histogram of P using 10 and 256 bins

% Display the histogram with 10 bins using imhist
figure;
imhist(P, 10);  
title('Histogram of Grayscale Image (10 bins)');

% Display the histogram with 256 bins using imhist
figure;
imhist(P, 256);  
title('Histogram of Grayscale Image (256 bins)');

% b) Perform histogram equalization and redisplay histograms

% Perform histogram equalization using histeq
P3 = histeq(P, 255);  

% Display the histogram of the equalized image with 10 bins using imhist
figure;
imhist(P3, 10);  
title('Histogram of Equalized Image (10 bins)');

% Display the histogram of the equalized image with 256 bins using imhist
figure;
imhist(P3, 256);  
title('Histogram of Equalized Image (256 bins)');

% Display the equalized image
figure;
imshow(P3);
title('Equalized Grayscale Image');

% c) Rerun histogram equalization on P3

% Perform histogram equalization again on P3
P4 = histeq(P3, 255);

% Display the histogram of P4 with 256 bins using imhist
figure;
imhist(P4, 256);  
title('Histogram of Re-Equalized Image (256 bins)');

% Display the re-equalized image
figure;
imshow(P4);
title('Re-Equalized Grayscale Image');

% Check if the equalized and re-equalized images are exactly the same
are_equal = isequal(P3, P4);

% Print the according response
if are_equal
    disp('P3 and P4 are exactly the same.');
else
    disp('P3 and P4 are different.');
end

% Subtract P3 from P4
difference = abs(double(P3) - double(P4));

% Display the difference
figure;
imshow(difference, []);
title('Differences Between P3 and P4');

% Check when the histogram equalization will converge

% Initial Image (P is the initial equalized image)
P_current = P;  % Start with the first equalized image
max_iterations = 100;  % Set a maximum number of iterations to avoid infinite loops
iterations = 0;  % Initialize iteration counter

% Loop to repeatedly equalize the image until convergence
while iterations < max_iterations
    P_next = histeq(P_current, 255);  % Re-equalize the current image
    
    % Check if the images are identical
    if isequal(P_current, P_next)
        disp(['Converged after ' num2str(iterations) ' iterations.']);
        break;  % Exit the loop if the images are the same
    end
    
    % Update for the next iteration
    P_current = P_next;
    iterations = iterations + 1;
    
    % If the loop reaches the maximum iterations, stop and report
    if iterations == max_iterations
        disp('Reached the maximum number of iterations without convergence.');
    end
end

% If it converged, display the number of iterations
if iterations < max_iterations
    disp(['Image equalization converged after ' num2str(iterations) ' iterations.']);
else
    disp('Image equalization did not converge within the max iterations.');
end

%% 2.3 Linear Spatial Filtering

% a) Generate Gaussian filters with sigma = 1.0 and sigma = 2.0

% Create the Gaussian filter with sigma = 1.0
sigma1 = 1.0;
h1 = fspecial('gaussian', [5 5], sigma1);  
h1 = h1 / sum(h1(:));  

% Create the Gaussian filter with sigma = 2.0
sigma2 = 2.0;
h2 = fspecial('gaussian', [5 5], sigma2);  
h2 = h2 / sum(h2(:));  

% Display the filters as 3D graphs using mesh
figure;
mesh(h1);
title('Gaussian Filter with Sigma = 1.0');

figure;
mesh(h2);
title('Gaussian Filter with Sigma = 2.0');

% b) Load and view the noisy image (with Gaussian noise)
noisy_image_gaussian = imread('img/lib-gn.jpg');  

% Display the noisy image
figure;
imshow(noisy_image_gaussian);
title('Image with Additive Gaussian Noise');

% c) Filter the noisy image using the Gaussian filters

% Apply the first filter (sigma = 1.0) to the noisy image
filtered_image1 = conv2(double(noisy_image_gaussian), h1, 'same');  

% Apply the second filter (sigma = 2.0) to the noisy image
filtered_image2 = conv2(double(noisy_image_gaussian), h2, 'same');  

% Convert the filtered images back to uint8 for display
filtered_image1 = uint8(filtered_image1);
filtered_image2 = uint8(filtered_image2);

% Display the filtered images
figure;
imshow(filtered_image1);
title('Filtered Image with Gaussian Filter (Sigma = 1.0)');

figure;
imshow(filtered_image2);
title('Filtered Image with Gaussian Filter (Sigma = 2.0)');

% d) Load and view the noisy image (with speckle noise)
noisy_image_speckle = imread('img/lib-sp.jpg');  

% Display the noisy image
figure;
imshow(noisy_image_speckle);
title('Image with Additive Speckle Noise');

% e) Filter the speckle noisy image using the Gaussian filters

% Apply the first filter (sigma = 1.0) to the speckle noisy image
filtered_image_speckle1 = conv2(double(noisy_image_speckle), h1, 'same');  

% Apply the second filter (sigma = 2.0) to the speckle noisy image
filtered_image_speckle2 = conv2(double(noisy_image_speckle), h2, 'same');  

% Convert the filtered images back to uint8 for display
filtered_image_speckle1 = uint8(filtered_image_speckle1);
filtered_image_speckle2 = uint8(filtered_image_speckle2);

% Display the filtered images
figure;
imshow(filtered_image_speckle1);
title('Filtered Speckle Image with Gaussian Filter (Sigma = 1.0)');

figure;
imshow(filtered_image_speckle2);
title('Filtered Speckle Image with Gaussian Filter (Sigma = 2.0)');

%% 2.4 Median Filtering

% a) No need to define a new filter

% b) Load and view the noisy image (Gaussian noise)
noisy_image_gaussian = imread('img/lib-gn.jpg');  

% Display the noisy image
figure;
imshow(noisy_image_gaussian);
title('Image with Additive Gaussian Noise');

% c) Apply median filtering to the noisy image using different neighborhood sizes

% Apply median filtering with 3x3 neighborhood
median_filtered_3x3_gaussian = medfilt2(noisy_image_gaussian, [3 3]);

% Apply median filtering with 5x5 neighborhood
median_filtered_5x5_gaussian = medfilt2(noisy_image_gaussian, [5 5]);

% Display the filtered images
figure;
imshow(median_filtered_3x3_gaussian);
title('Median Filtered Gaussian Image (3x3 Neighborhood)');

figure;
imshow(median_filtered_5x5_gaussian);
title('Median Filtered Gaussian Image (5x5 Neighborhood)');

% d) Load and view the noisy image (Speckle noise)
noisy_image_speckle = imread('img/lib-sp.jpg');  

% Display the noisy image
figure;
imshow(noisy_image_speckle);
title('Image with Additive Speckle Noise');

% e) Apply median filtering to the speckle noisy image

% Apply median filtering with 3x3 neighborhood
median_filtered_3x3_speckle = medfilt2(noisy_image_speckle, [3 3]);

% Apply median filtering with 5x5 neighborhood
median_filtered_5x5_speckle = medfilt2(noisy_image_speckle, [5 5]);

% Display the filtered images
figure;
imshow(median_filtered_3x3_speckle);
title('Median Filtered Speckle Image (3x3 Neighborhood)');

figure;
imshow(median_filtered_5x5_speckle);
title('Median Filtered Speckle Image (5x5 Neighborhood)');

%% 2.5 Suppressing Noise Interference Patterns

% a) Load and display the image with interference patterns
interference_image = imread('img/pck-int.jpg');  

% Display the interference image
figure;
imshow(interference_image);
title('Original Image with Interference Patterns');

% b) Compute the Fourier Transform and power spectrum

% Compute the 2D Fourier Transform of the image
F = fft2(double(interference_image));

% Compute the power spectrum
S = abs(F).^2;

% Shift the zero-frequency component to the center and display the power spectrum
figure;
imagesc(fftshift(S.^0.1));  
colormap('default');
title('Power Spectrum of Interference Image (with fftshift)');

% c) Redisplay the power spectrum without fftshift and measure peaks

% Display the power spectrum without fftshift
figure;
imagesc(S.^0.1);  
colormap('default');
title('Power Spectrum of Interference Image (without fftshift)');

% Use ginput to measure the coordinates of the peaks manually
disp('Use ginput to select the frequency peaks (2 peaks should be selected)');
[peak_x, peak_y] = ginput(2);  

% Display the coordinates
fprintf('Selected peak coordinates: (%.1f, %.1f) and (%.1f, %.1f)\n', peak_x(1), peak_y(1), peak_x(2), peak_y(2));

% d) Set the 5x5 neighborhood around the peaks to zero in the Fourier domain

% Set a 5x5 neighborhood around each peak to zero in the Fourier transform F
neighborhood_size = 2;  
F_filtered = F;

for i = 1:length(peak_x)
    x = round(peak_x(i));
    y = round(peak_y(i));
    
    % Zero out a 5x5 neighborhood around each peak
    F_filtered(y-neighborhood_size:y+neighborhood_size, x-neighborhood_size:x+neighborhood_size) = 0;
end

% Recompute the power spectrum after filtering
S_filtered = abs(F_filtered).^2;

% Display the filtered power spectrum
figure;
imagesc(fftshift(S_filtered.^0.1));  
colormap('default');
title('Filtered Power Spectrum (after removing peaks)');

% e) Compute the inverse Fourier transform and display the resultant image

% Compute the inverse Fourier transform to get the filtered image
filtered_image = ifft2(F_filtered);

% Take the real part of the result and convert it back to uint8
filtered_image = real(filtered_image);  
filtered_image = uint8(filtered_image);

% Display the filtered image
figure;
imshow(filtered_image);
title('Filtered Image after Removing Interference');

% f) Filter the 'primate-caged.jpg' image to attempt removing the cage

% Load the primate-caged image
primate_image = imread('img/primate-caged.jpg');  

% Check if the image is RGB, convert it to grayscale if necessary
if size(primate_image, 3) == 3
    primate_image = rgb2gray(primate_image);  
end

% Display the original image
figure;
imshow(primate_image);
title('Original Primate Caged Image');

% Compute the 2D Fourier Transform of the grayscale image
F_primate = fft2(double(primate_image));

% Compute the power spectrum of the primate image
S_primate = abs(F_primate).^2;

% Apply logarithmic scaling to the power spectrum for better visibility
S_primate_log = log(1 + S_primate);  

% Display the power spectrum using logarithmic scaling
figure;
imagesc(fftshift(S_primate_log));  
colormap('default');
title('Logarithmic Power Spectrum of Primate Image (with fftshift)');
colorbar;  
hold on;  

% Initialize arrays to store selected points and window sizes
selected_points = [];
neighborhood_size = 2;  

% Loop until the user presses Enter
disp('Click on points to zero out. Press Enter when done.');
while true
    [x, y, button] = ginput(1);  
    if isempty(button)  
        break;
    end
    
    % Store the selected point
    selected_points = [selected_points; x, y];
    
    % Plot the selected point (cross) on the power spectrum
    plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 2);  
    
    % Draw a rectangle around the selected point to indicate the window
    rectangle('Position', [x - neighborhood_size - 0.5, y - neighborhood_size - 0.5, ...
               2*neighborhood_size + 1, 2*neighborhood_size + 1], 'EdgeColor', 'g', 'LineWidth', 1.5);
    
    % Update the plot immediately
    drawnow;
end

% Initialize the filtered Fourier transform
F_primate_filtered = fftshift(F_primate);  % Work with shifted Fourier transform directly

% Get the number of rows and columns
[rows, cols] = size(F_primate_filtered);

% Zero out a 5x5 neighborhood around each selected point
for i = 1:size(selected_points, 1)
    x = round(selected_points(i, 1));
    y = round(selected_points(i, 2));

    % Ensure the indices are valid and within bounds
    x = max(neighborhood_size + 1, min(cols - neighborhood_size, x));
    y = max(neighborhood_size + 1, min(rows - neighborhood_size, y));
    
    % Zero out a 5x5 neighborhood around the selected point
    F_primate_filtered(y-neighborhood_size:y+neighborhood_size, x-neighborhood_size:x+neighborhood_size) = 0;
end

% Visualize the modified power spectrum after zeroing out the selected areas
S_primate_filtered = abs(F_primate_filtered).^2;  % Recompute the power spectrum after filtering
S_primate_filtered_log = log(1 + S_primate_filtered);  % Apply logarithmic scaling for better visualization

figure;
imagesc(S_primate_filtered_log);  % Display the filtered power spectrum
colormap('default');
title('Filtered Power Spectrum (after removing selected areas)');
colorbar;

% Compute the inverse Fourier transform to get the filtered primate image
primate_filtered_image = ifft2(ifftshift(F_primate_filtered));  % Shift back and compute inverse Fourier transform

% Take the real part and convert back to uint8
primate_filtered_image = real(primate_filtered_image);
primate_filtered_image = uint8(mat2gray(primate_filtered_image) * 255);  

% Display the filtered primate image
figure;
imshow(primate_filtered_image);
title('Filtered Primate Image (after removing multiple selected areas)');

%% 2.6 Undoing Perspective Distortion of Planar Surface

% a) Load and display the slanted image of the book
P = imread('img/book.jpg');  % Load the slanted image of the book
figure;
imshow(P);
title('Original Slanted Image of the Book');

% b) Use ginput to manually select the four corners of the book
disp('Select the four corners of the book in the image');
[X, Y] = ginput(4);  % Manually select four corners of the book

% Define the desired coordinates for the corners of an A4 sheet (210 mm x 297 mm)
% X and Y represent the corners of the book in the original image
% x and y represent the corners of the book in the corrected (frontal) image
x = [0, 210, 210, 0];  % X-coordinates of the desired output
y = [0, 0, 297, 297];  % Y-coordinates of the desired output

% c) Set up the matrices to estimate the projective transformation
A = [];
v = [];

for i = 1:4
    A = [A; X(i), Y(i), 1, 0, 0, 0, -x(i)*X(i), -x(i)*Y(i)];
    A = [A; 0, 0, 0, X(i), Y(i), 1, -y(i)*X(i), -y(i)*Y(i)];
    v = [v; x(i); y(i)];
end

% Solve for the transformation parameters (u)
u = A \ v;

% Convert the solution vector into the 3x3 projective transformation matrix U
U = reshape([u; 1], 3, 3)';

% Verify the transformation by transforming the original coordinates
w = U * [X'; Y'; ones(1, 4)];
w = w ./ (ones(3,1) * w(3,:));  % Normalize to get the transformed points

% Display the transformed coordinates
disp('Transformed coordinates:');
disp(w);

% d) Apply the projective transformation to warp the image
T = maketform('projective', U');  % Create the projective transformation
P2 = imtransform(P, T, 'XData', [0 210], 'YData', [0 297]);  % Warp the image

% e) Display the result
figure;
imshow(P2);
title('Warped Image (Frontal View of the Book)');

% f) Predefined color selection and matching in the warped image

% Convert the entire image to HSV for color detection
P2_hsv = rgb2hsv(P2);

% Define the updated target color HSV range for reddish, pink, and orange hues
hue_min = 0 / 360;   % Start from 0 degrees (red)
hue_max = 25 / 360;  % Extend up to 25 degrees (covering reddish-orange)
sat_min = 30 / 100;  % Allow lower saturation to capture light pinks and faded colors
sat_max = 100 / 100; % Max saturation to capture vibrant colors
val_min = 60 / 100;  % Allow darker values to include deeper reds
val_max = 100 / 100; % Max brightness to capture light shades like pink or orange

% Create a binary mask based on the updated color thresholds
color_mask = (P2_hsv(:,:,1) >= hue_min) & (P2_hsv(:,:,1) <= hue_max) & ...
             (P2_hsv(:,:,2) >= sat_min) & (P2_hsv(:,:,2) <= sat_max) & ...
             (P2_hsv(:,:,3) >= val_min) & (P2_hsv(:,:,3) <= val_max);

% Perform morphological operations to clean up the mask (remove noise, close gaps)
color_mask_cleaned = imclose(color_mask, strel('rectangle', [10, 10]));
color_mask_cleaned = imopen(color_mask_cleaned, strel('rectangle', [5, 5]));

% Label connected components in the mask
connected_components = bwconncomp(color_mask_cleaned);

% Measure properties of the connected components (such as area and bounding box)
region_stats = regionprops(connected_components, 'BoundingBox', 'Area');

% Check if any regions are found
if ~isempty(region_stats)
    % Find the largest component, assuming it corresponds to the target area
    [~, largest_component_idx] = max([region_stats.Area]);
    bounding_box = region_stats(largest_component_idx).BoundingBox;

    % Display the original warped image
    figure;
    imshow(P2);
    title('Warped Image with Detected Color Region');
    hold on;

    % Draw a rectangle around the largest detected color region
    rectangle('Position', bounding_box, 'EdgeColor', 'g', 'LineWidth', 2)

    red_channel = ones(size(P2, 1), size(P2, 2));    % Red channel (all ones for full red)
    green_channel = zeros(size(P2, 1), size(P2, 2));  % Green channel (all zeros)
    blue_channel = ones(size(P2, 1), size(P2, 2));   % Blue channel (all ones for full blue)
    
    % Combine the channels into the final colored mask (purple mask)
    colored_mask = cat(3, red_channel, green_channel, blue_channel);

    % Apply the mask to the detected region with transparency
    h_mask = imshow(colored_mask);
    set(h_mask, 'AlphaData', 0.3 * color_mask_cleaned);  % Set transparency based on the mask (30% opacity)

    hold off;
else
    disp('No matching color area detected in the image.');
end

%% 2.7 Code Two Perceptrons

% Define the input data and labels (two-class classification problem)
X = [-1 -1 1; -1 1 -1; 1 -1 -1; 1 1 1];  % Input data (4 samples, 3 features including bias)
y = [-1; -1; 1; 1];  % Desired class labels

% Find the dynamic limits for the plots
x_min = min(X(:, 1)) - 1;  % Add a margin to the minimum x value
x_max = max(X(:, 1)) + 1;  % Add a margin to the maximum x value
y_min = min(X(:, 2)) - 1;  % Add a margin to the minimum y value
y_max = max(X(:, 2)) + 1;  % Add a margin to the maximum y value

% a) Perceptron Algorithm 1 (Classical Perceptron)

% Initialization
w1 = rand(3, 1);  % Initialize weights randomly to avoid zero initialization
alpha1 = 0.5;  % Learning rate
max_iter1 = 1000;  % Maximum number of iterations
misclassifications = zeros(max_iter1, 1);  % To store the number of misclassifications at each iteration

% Perceptron Algorithm 1 training
for iter1 = 1:max_iter1
    misclassified = 0;  % Count the number of misclassified samples
    for k = 1:size(X, 1)
        if y(k) * (w1' * X(k, :)') <= 0
            % Update rule for misclassified samples
            w1 = w1 + alpha1 * y(k) * X(k, :)';
            misclassified = misclassified + 1;
        end
    end
    misclassifications(iter1) = misclassified;  % Track the number of misclassified samples
    
    if misclassified == 0
        break;  % Stop if all samples are classified correctly
    end
end

% Display final weights for Perceptron Algorithm 1
disp('Final weights for Perceptron Algorithm 1:');
disp(w1);

% Plotting the number of misclassifications over iterations (+3 iterations after convergence)
max_iter_plot1 = min(iter1 + 3, max_iter1);  % Ensure we don't exceed the array size
figure;
plot(1:max_iter_plot1, misclassifications(1:max_iter_plot1), 'LineWidth', 2);
xlabel('Iterations');
ylabel('Number of Misclassifications');
title('Perceptron Algorithm 1: Misclassifications over Iterations (+3 extra iterations)');
hold on;
xline(iter1, '--r', 'LineWidth', 2);  % Vertical line at convergence iteration
legend('Misclassifications', 'Convergence Point');
hold off;

% Plotting the decision boundary for Perceptron Algorithm 1
figure;
hold on;

% Plot the data points for both classes
scatter(X(y == 1, 1), X(y == 1, 2), 'r', 'filled');  % Class 1
scatter(X(y == -1, 1), X(y == -1, 2), 'b', 'filled');  % Class -1

% Calculate and plot the decision boundary (only if w(2) is non-zero)
x_vals = linspace(x_min, x_max, 100);  % Generate x values for the boundary
if w1(2) ~= 0
    y_vals = -(w1(1) * x_vals + w1(3)) / w1(2);  % Decision boundary equation
    plot(x_vals, y_vals, 'k-', 'LineWidth', 2);  % Decision boundary
    title('Perceptron Algorithm 1: Decision Boundary');
else
    disp('No valid decision boundary. Weights may need more training.');
end

% Formatting the plot
xlabel('x1');
ylabel('x2');
legend('Class 1', 'Class -1', 'Decision Boundary');
xlim([x_min x_max]);  % Set dynamic x-axis limits
ylim([y_min y_max]);  % Set dynamic y-axis limits
hold off;

% b) Perceptron Algorithm 2 (Gradient Descent-Based Perceptron)

% Initialization
w2 = rand(3, 1);  % Initialize weights randomly
alpha2 = 0.01;  % Learning rate
max_iter2 = 1000;  % Maximum number of iterations
errors = zeros(max_iter2, 1);  % To store the error at each iteration

% Perceptron Algorithm 2 training using gradient descent
for iter2 = 1:max_iter2
    total_error = 0;
    for k = 1:size(X, 1)
        % Compute the output and error
        r = y(k);  % Desired output
        output = w2' * X(k, :)';  % Predicted output
        error = r - output;  % Error
        total_error = total_error + 0.5 * error^2;  % Accumulate squared error
        
        % Weight update using gradient descent
        w2 = w2 + alpha2 * error * X(k, :)';
    end
    errors(iter2) = total_error;
    
    % Stop if the error is sufficiently small
    if total_error < 1e-6
        break;
    end
end

% Display final weights for Perceptron Algorithm 2
disp('Final weights for Perceptron Algorithm 2:');
disp(w2);

% Plotting the error over iterations (+3 iterations after convergence)
max_iter_plot2 = min(iter2 + 3, max_iter2);  % Ensure we don't exceed the array size
figure;
plot(1:max_iter_plot2, errors(1:max_iter_plot2), 'LineWidth', 2);
xlabel('Iterations');
ylabel('Error');
title('Perceptron Algorithm 2: Error over Iterations (+3 extra iterations)');
hold on;
xline(iter2, '--r', 'LineWidth', 2);  % Vertical line at convergence iteration
legend('Error', 'Convergence Point');
hold off;

% Plotting the decision boundary for Perceptron Algorithm 2
figure;
hold on;

% Plot the data points for both classes
scatter(X(y == 1, 1), X(y == 1, 2), 'r', 'filled');  % Class 1
scatter(X(y == -1, 1), X(y == -1, 2), 'b', 'filled');  % Class -1

% Calculate and plot the decision boundary
x_vals = linspace(x_min, x_max, 100);  % Generate x values for the boundary
if w2(2) ~= 0
    y_vals = -(w2(1) * x_vals + w2(3)) / w2(2);  % Decision boundary equation
    plot(x_vals, y_vals, 'k-', 'LineWidth', 2);  % Decision boundary
    title('Perceptron Algorithm 2: Decision Boundary');
else
    disp('No valid decision boundary. Weights may need more training.');
end

% Formatting the plot
xlabel('x1');
ylabel('x2');
legend('Class 1', 'Class -1', 'Decision Boundary');
xlim([x_min x_max]);  % Set dynamic x-axis limits
ylim([y_min y_max]);  % Set dynamic y-axis limits
hold off;
