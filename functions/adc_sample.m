function  signal = adc_sample(N_bits, A, signal)

    %ADC setup
    N_levels = 2^N_bits;
    A_max = +A + 0.00001;
    A_min = -A - 0.00001;
    
    %bring into range [0,A_max-A_min]
    signal = signal - A_min;
    
    %normalize od [0,1]
    signal = signal/(A_max-A_min);
    
    %multiply by N levels to bring into rang [0,N]
    signal = signal*N_levels;
    
    %shift donwn to [-0.5, N_level-0.5]
    signal = signal - 0.5;
    
    %round off to nearest number
    signal = round(signal);
    
    %reverse process
    signal = signal + 0.5;
    signal = signal/N_levels;
    signal = signal*(A_max - A_min);
    signal = signal + A_min;
    
end

