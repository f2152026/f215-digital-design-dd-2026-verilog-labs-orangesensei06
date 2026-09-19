module tb;

  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  reg exp_gt;
  reg exp_lt;
  reg exp_eq;

  integer a_value;
  integer b_value;
  integer errors;

  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  initial begin
    errors = 0;

    for (a_value = 0; a_value < 4; a_value = a_value + 1) begin
      for (b_value = 0; b_value < 4; b_value = b_value + 1) begin
        t_a = a_value;
        t_b = b_value;
        #1;

        exp_gt = (a_value > b_value);
        exp_lt = (a_value < b_value);
        exp_eq = (a_value == b_value);

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b got GT=%b LT=%b EQ=%b expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("Task 3: ");
    $display("%0d/16 tests passed", 16 - errors);
    $finish;
  end

endmodule
