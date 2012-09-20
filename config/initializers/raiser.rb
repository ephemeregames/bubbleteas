# Add .inspect to any object passed, than call Kernel.raise
module Kernel
  def raiser(*args)
    raise args.collect(&:inspect).join(", ")
  end
end
