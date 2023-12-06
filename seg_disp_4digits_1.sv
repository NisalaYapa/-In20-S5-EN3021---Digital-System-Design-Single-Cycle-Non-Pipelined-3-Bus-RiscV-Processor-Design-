module seg_disp_4digits_1(
    input wire [31:0] binary_input, // Input for a 32-bit binary value
	 input enable,
    output reg [27:0] segments     // Output for the segments of four 7-segment displays
);

    reg [15:0] digits[0:3];  // Array to hold each individual digit

    integer temp_value;

    // Convert binary to decimal and separate into digits
    always @(enable) begin
        temp_value = binary_input;

        for (int i = 0; i < 4; i = i + 1) begin
            digits[i] = temp_value % 10;
            temp_value = temp_value / 10;
        end
    end

    // Display logic for each digit
    always @* begin
        for (int i = 0; i < 4; i = i + 1) begin
            case (digits[i])
                4'b0000: segments[(i * 7) +: 7] = 7'b1000000; // Display 0
                4'b0001: segments[(i * 7) +: 7] = 7'b1111001; // Display 1
                4'b0010: segments[(i * 7) +: 7] = 7'b0100100; // Display 2
                4'b0011: segments[(i * 7) +: 7] = 7'b0110000; // Display 3
                4'b0100: segments[(i * 7) +: 7] = 7'b0011001; // Display 4
                4'b0101: segments[(i * 7) +: 7] = 7'b0010010; // Display 5
                4'b0110: segments[(i * 7) +: 7] = 7'b0000010; // Display 6
                4'b0111: segments[(i * 7) +: 7] = 7'b1111000; // Display 7
                4'b1000: segments[(i * 7) +: 7] = 7'b0000000; // Display 8
                4'b1001: segments[(i * 7) +: 7] = 7'b0010000; // Display 9
                default: segments[(i * 7) +: 7] = 7'b1111111; // Turn off all segments if not a valid digit
            endcase
        end
    end

endmodule 
/*
module seg_disp_4digits_1(
    input reg enable,               // Enable signal for the module
    input reg [31:0] binary_input, // Input for a 32-bit binary value
    output reg [27:0] segments      // Output for the segments of four 7-segment displays
);

    reg [15:0] digits[0:3];  // Array to hold each individual digit
	 reg started = 0;

    integer temp_value;

    // Convert binary to decimal and separate into digits when enabled
    always @(enable) begin
        temp_value = binary_input;
		  started = 1;

        for (int i = 0; i < 4; i = i + 1) begin
            digits[i] = temp_value % 10;
            temp_value = temp_value / 10;
        end
    end

    // Display logic for each digit when enabled
    always @(started) begin
        for (int i = 0; i < 4; i = i + 1) begin
            case (digits[i])
                4'b0000: segments[(i * 7) +: 7] = 7'b1000000; // Display 0
                4'b0001: segments[(i * 7) +: 7] = 7'b1111001; // Display 1
                4'b0010: segments[(i * 7) +: 7] = 7'b0100100; // Display 2
                4'b0011: segments[(i * 7) +: 7] = 7'b0110000; // Display 3
                4'b0100: segments[(i * 7) +: 7] = 7'b0011001; // Display 4
                4'b0101: segments[(i * 7) +: 7] = 7'b0010010; // Display 5
                4'b0110: segments[(i * 7) +: 7] = 7'b0000010; // Display 6
                4'b0111: segments[(i * 7) +: 7] = 7'b1111000; // Display 7
                4'b1000: segments[(i * 7) +: 7] = 7'b0000000; // Display 8
                4'b1001: segments[(i * 7) +: 7] = 7'b0010000; // Display 9
                default: segments[(i * 7) +: 7] = 7'b1111111; // Turn off all segments if not a valid digit
            endcase
				started = 0;
        end
    end

endmodule */
/*
module seg_disp_4digits_1(
    input wire [31:0] binary_input, // Input for a 32-bit binary value
    output reg [27:0] segments     // Output for the segments of four 7-segment displays
);

    reg [15:0] digits[0:3];  // Array to hold each individual digit
    integer temp_value;
    reg [31:0] delay_counter; // Counter for delay

    // Delay before processing the input
    always @* begin
        if (delay_counter < 1000000) begin // Adjust the delay count as needed
            delay_counter = delay_counter + 1;
        end
    end

    // Convert binary to decimal and separate into digits after delay
    always @* begin
        if (delay_counter >= 1000000) begin // Process inputs after delay
            temp_value = binary_input;

            for (int i = 0; i < 4; i = i + 1) begin
                digits[i] = temp_value % 10;
                temp_value = temp_value / 10;
            end
        end
    end

    // Display logic for each digit after the delay
    always @* begin
        if (delay_counter >= 1000000) begin // Display logic executed after delay
            for (int i = 0; i < 4; i = i + 1) begin
                case (digits[i])
                4'b0000: segments[(i * 7) +: 7] = 7'b1000000; // Display 0
                4'b0001: segments[(i * 7) +: 7] = 7'b1111001; // Display 1
                4'b0010: segments[(i * 7) +: 7] = 7'b0100100; // Display 2
                4'b0011: segments[(i * 7) +: 7] = 7'b0110000; // Display 3
                4'b0100: segments[(i * 7) +: 7] = 7'b0011001; // Display 4
                4'b0101: segments[(i * 7) +: 7] = 7'b0010010; // Display 5
                4'b0110: segments[(i * 7) +: 7] = 7'b0000010; // Display 6
                4'b0111: segments[(i * 7) +: 7] = 7'b1111000; // Display 7
                4'b1000: segments[(i * 7) +: 7] = 7'b0000000; // Display 8
                4'b1001: segments[(i * 7) +: 7] = 7'b0010000; // Display 9
                default: segments[(i * 7) +: 7] = 7'b1111111; // Turn off all segments if not a valid digit
            endcase
            end
        end
    end

endmodule */


