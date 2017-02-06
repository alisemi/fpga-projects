library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.std_logic_unsigned.all;
use ieee.math_real.all;

entity vga is
    Port ( 
        CLK_I : in STD_LOGIC;
        VGA_HS_O : out STD_LOGIC;
        VGA_VS_O : out STD_LOGIC;
        VGA_RED_O : out STD_LOGIC_VECTOR (3 downto 0);
        VGA_BLUE_O : out STD_LOGIC_VECTOR (3 downto 0);
        VGA_GREEN_O : out STD_LOGIC_VECTOR (3 downto 0);
        Y : out natural range 0 to 1280;
        X : out natural range 0 to 1024;
        R : in natural range 0 to 15;
        G : in natural range 0 to 15;
        B : in natural range 0 to 15
        --reset : in STD_LOGIC
    );
end vga;

architecture Behavioral of vga is
    
    component clk_wiz_0
        port
        (
            clk_in1           : in     std_logic;
            clk_out1          : out    std_logic
            --reset             : in std_logic
        );
    end component;

    --***1280x1024@60Hz***--
    constant FRAME_WIDTH : natural := 1280;
    constant FRAME_HEIGHT : natural := 1024;
    
    constant H_FP : natural := 48; --H front porch width (pixels)
    constant H_PW : natural := 112; --H sync pulse width (pixels)
    constant H_MAX : natural := 1688; --H total period (pixels)
    
    constant V_FP : natural := 1; --V front porch width (lines)
    constant V_PW : natural := 3; --V sync pulse width (lines)
    constant V_MAX : natural := 1066; --V total period (lines)
    
    constant H_POL : std_logic := '1';
    constant V_POL : std_logic := '1';
  
    -- Pixel clock, in this case 108 MHz
    signal pxl_clk : std_logic;
    -- The active signal is used to signal the active region of the screen (when not blank)
    signal active  : std_logic;
    
    -- Horizontal and Vertical counters
    signal h_cntr_reg : std_logic_vector(11 downto 0) := (others =>'0');
    signal v_cntr_reg : std_logic_vector(11 downto 0) := (others =>'0');
    
    -- Pipe Horizontal and Vertical Counters
--    signal h_cntr_reg_dly   : std_logic_vector(11 downto 0) := (others => '0');
--    signal v_cntr_reg_dly   : std_logic_vector(11 downto 0) := (others => '0');
    
    -- Horizontal and Vertical Sync
    signal h_sync_reg : std_logic := not(H_POL);
    signal v_sync_reg : std_logic := not(V_POL);
    -- Pipe Horizontal and Vertical Sync
--    signal h_sync_reg_dly : std_logic := not(H_POL);
--    signal v_sync_reg_dly : std_logic :=  not(V_POL);
    
    signal vga_red_reg   : std_logic_vector(3 downto 0) := (others =>'0');
    signal vga_green_reg : std_logic_vector(3 downto 0) := (others =>'0');
    signal vga_blue_reg  : std_logic_vector(3 downto 0) := (others =>'0');
    
begin
    pixel_clock : clk_wiz_0 port map (clk_in1 => CLK_I, clk_out1 => pxl_clk);--, reset => reset);
    
    -- Horizontal counter
    process (pxl_clk)
    begin
        if (rising_edge(pxl_clk)) then
            if (h_cntr_reg = (H_MAX - 1)) then
                h_cntr_reg <= (others =>'0');
            else
                h_cntr_reg <= h_cntr_reg + 1;
            end if;
        end if;
    end process;
    -- Vertical counter
    process (pxl_clk)
    begin
        if (rising_edge(pxl_clk)) then
            if ((h_cntr_reg = (H_MAX - 1)) and (v_cntr_reg = (V_MAX - 1))) then
                v_cntr_reg <= (others =>'0');
            elsif (h_cntr_reg = (H_MAX - 1)) then
                v_cntr_reg <= v_cntr_reg + 1;
            end if;
        end if;
    end process;
    -- Horizontal sync
    process (pxl_clk)
    begin
        if (rising_edge(pxl_clk)) then
            if (h_cntr_reg >= (H_FP + FRAME_WIDTH - 1)) and (h_cntr_reg < (H_FP + FRAME_WIDTH + H_PW - 1)) then
                h_sync_reg <= H_POL;
            else
                h_sync_reg <= not(H_POL);
            end if;
        end if;
    end process;
    -- Vertical sync
    process (pxl_clk)
    begin
        if (rising_edge(pxl_clk)) then
            if (v_cntr_reg >= (V_FP + FRAME_HEIGHT - 1)) and (v_cntr_reg < (V_FP + FRAME_HEIGHT + V_PW - 1)) then
                v_sync_reg <= V_POL;
            else
                v_sync_reg <= not(V_POL);
            end if;
        end if;
    end process;
     
    process (pxl_clk)
    begin
        if (rising_edge(pxl_clk)) then
        
            if (h_cntr_reg < FRAME_WIDTH and v_cntr_reg < FRAME_HEIGHT) then
                X <= conv_integer(h_cntr_reg);
                Y <= conv_integer(v_cntr_reg);
                vga_red_reg    <=  conv_std_logic_vector(R, 4);
                vga_green_reg  <=  conv_std_logic_vector(G, 4);
                vga_blue_reg   <=  conv_std_logic_vector(B, 4);
            else
                vga_red_reg     <= "0000";
                vga_green_reg   <= "0000";
                vga_blue_reg    <= "0000";
            end if;
            
--            v_sync_reg_dly      <= v_sync_reg;
--            h_sync_reg_dly      <= h_sync_reg;
        
        end if;
    end process;
    
    VGA_HS_O    <= h_sync_reg;
    VGA_VS_O    <= v_sync_reg;
    VGA_RED_O   <= vga_red_reg;
    VGA_GREEN_O <= vga_green_reg;
    VGA_BLUE_O  <= vga_blue_reg;

end Behavioral;
