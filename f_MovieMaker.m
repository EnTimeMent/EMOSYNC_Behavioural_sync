% ========================================================================
% Walk@Home PROJECT
% NOTICE : f_MovieMaker
%
% Fonction permettant de creer un film a partir d'images au format jpg 
% placees dans un dossier.
%
% INPUT :
% * myFolder : Dossier ou sont placees les figures au format jpg.
%
% OUTPUT :
% Enregistrement de la video.
%
% ========================================================================

function [] = f_MovieMaker(myFolder,NameVideo)

% INITIALISATION :
% GLOBALS;

% CREATION DE LA VIDEO :

if ~isdir(myFolder)
    errorMessage = sprintf('Error: The following folder does not exist:\n%s', myFolder);
    uiwait(warndlg(errorMessage));
    return;
end

% Get a directory listing.
filePattern = fullfile(myFolder,  '*.jpg');
jpgFiles = dir(filePattern);
% Open the video writer object.
writerObj = VideoWriter(NameVideo);

writerObj.FrameRate = 20;
open(writerObj);

% Go through image by image writing it out to the AVI file.
for frameNumber = 1 : length(jpgFiles)
    % Construct the full filename.
%     baseFileName = jpgFiles(frameNumber).name;
    baseFileName = ['T',num2str(frameNumber),'.jpg'];
    fullFileName = fullfile(myFolder, baseFileName);
    % Display image name in the command window.
    fprintf(1, 'Now reading %s\n', fullFileName);
    % Display image in an axes control.
    thisimage = imread(fullFileName); 
    drawnow; % Force display to update immediately.
    % Write this frame out to the AVI file.
    writeVideo(writerObj, thisimage);
end

% Close down the video writer object to finish the file.
close(writerObj);

% VideoWriter Create a video writer object.
%     
%     OBJ = VideoWriter(FILENAME) constructs a VideoWriter object to
%     write video data to an AVI file that uses Motion JPEG compression.  
%     FILENAME is a string enclosed in single quotation marks that specifies 
%     the name of the file to create. If filename does not include the 
%     extension '.avi', the VideoWriter constructor appends the extension.
%  
%     OBJ = VideoWriter( FILENAME, PROFILE ) applies a set of properties
%     tailored to a specific file format (such as 'Uncompressed AVI') to 
%     a VideoWriter object. PROFILE is a string enclosed in single 
%     quotation marks that describes the type of file to create. 
%     Specifying a profile sets default values for video properties such 
%     as VideoCompressionMethod. Possible values:
%       'Archival'         - Motion JPEG 2000 file with lossless compression
%       'Motion JPEG AVI'  - Compressed AVI file using Motion JPEG codec.
%                            (default)
%       'Motion JPEG 2000' - Compressed Motion JPEG 2000 file
%       'MPEG-4'           - Compressed MPEG-4 file with H.264 encoding 
%                            (Windows 7 and Mac OS X 10.7 only)
%       'Uncompressed AVI' - Uncompressed AVI file with RGB24 video.
%       'Indexed AVI'      - Uncompressed AVI file with Indexed video.
%       'Grayscale AVI'    - Uncompressed AVI file with Grayscale video.
%  
%   Methods:
%     open        - Open file for writing video data. 
%     close       - Close file after writing video data.
%     writeVideo  - Write video data to file.
%     getProfiles - List profiles and file format supported by VideoWriter. 
%  
%   Properties:
%     ColorChannels          - Number of color channels in each output 
%                              video frame.
%     Colormap               - Numeric matrix having dimensions Px3 that
%                              contains color information about the video
%                              file. The colormap can have a maximum of
%                              256 entries of type 'uint8' or 'double'.
%                              The entries of the colormap must integers.
%                              Each row of Colormap specifies the red,
%                              green and blue components of a single
%                              color. The colormap can be set: 
%                                 - Explicitly before the call to open OR
%                                 - Using the colormap field of the FRAME
%                                   struct at the time of writing the
%                                   first frame.
%                              Only applies to objects associated with
%                              Indexed AVI files. After you call open,
%                              you cannot change the Colormap value.
%     CompressionRatio       - Number greater than 1 indicating the
%                              target ratio between the number of bytes
%                              in the input image and compressed image.
%                              Only applies to objects associated with
%                              Motion JPEG 2000 files. After you call
%                              open, you cannot change the  
%                              CompressionRatio value.  
%     Duration               - Scalar value specifying the duration of the 
%                              file in seconds.
%     FileFormat             - String specifying the type of file to write.
%     Filename               - String specifying the name of the file.
%     FrameCount             - Number of frames written to the video file.
%     FrameRate              - Rate of playback for the video in frames per
%                              second. After you call open, you cannot 
%                              change the FrameRate value.
%     Height                 - Height of each video frame in pixels. 
%                              The writeVideo method sets values for Height
%                              and Width based on the dimensions of the 
%                              first frame.
%     LosslessCompression    - Boolean value indicating whether lossy or
%                              lossless compression is to be used. If
%                              true, any specified value for the
%                              CompressionRatio property is ignored. Only
%                              applies to objects associated with Motion
%                              JPEG 2000 files. After you call open, you
%                              cannot change the LosslessCompression value.
%     MJ2BitDepth            - Number of least significant bits in the
%                              input image data, from 1 to 16. Only
%                              applies to objects associated with Motion
%                              JPEG 2000 files. 
%     Path                   - String specifying the fully qualified file
%                              path.
%     Quality                - Integer from 0 through 100. Only applies to
%                              objects associated with the Motion JPEG
%                              AVI and MPEG-4 profiles. Higher quality
%                              numbers result in higher video quality and
%                              larger file sizes. Lower quality numbers
%                              result in lower video quality and smaller
%                              file sizes. After you call open, you cannot 
%                              change the Quality value.
%     VideoBitsPerPixel      - Number of bits per pixel in each output 
%                              video frame.
%     VideoCompressionMethod - String indicating the type of video 
%                              compression.
%     VideoFormat            - String indicating the MATLAB representation 
%                              of the video format.    
%     Width                  - Width of each video frame in pixels. 
%                              The writeVideo method sets values for Height
%                              and Width based on the dimensions of the 
%                              first frame.
%  
%   Example:
%   
%     % Prepare the new file.
%     vidObj = VideoWriter('peaks.avi');
%     open(vidObj);
%  
%     % Create an animation.
%     Z = peaks; surf(Z);
%     axis tight manual
%     set(gca,'nextplot','replacechildren');
%  
%     for k = 1:20
%        surf(sin(2*pi*k/20)*Z,Z)
%  
%        % Write each frame to the file.
%        currFrame = getframe(gcf);
%        writeVideo(vidObj,currFrame);
%     end
%   
%     % Close the file.
%     close(vidObj);
%   
%   See also VideoWriter/open, VideoWriter/close, 
%            VideoWriter/writeVideo, VideoWriter.getProfiles.
% 
%     Reference page for VideoWriter