function SoundBite(themePlayer, name)
%SOUNDBITE plays sound

pause(themePlayer);

disp(strcat('Playing Sound:  ', name));

play = true;

switch name
    case 'Squirtle'
        [y,Fs] = audioread('Squirtle.wav');
    case 'Bulbasaur'
        [y,Fs] = audioread('Bulbasaur.wav');
    case 'Pikachu'
        [y,Fs] = audioread('pika2.wav');
    case 'Choose'
        [y,Fs] = audioread('poke-who.wav');
    otherwise
        play = false;
end

if play
    sound(y, Fs);
end

end

