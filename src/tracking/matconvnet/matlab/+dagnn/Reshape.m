classdef Reshape < dagnn.ElementWise
  properties
    shape = {} ;
  end

  properties (Transient)
    inputSizes = {}
  end

  methods
    function outputs = forward(obj, inputs, params)
      outputs{1} = vl_nnreshape(inputs{1}, obj.shape) ;
      obj.inputSizes = cellfun(@size, inputs, 'UniformOutput', false) ;
    end

    function [derInputs, derParams] = backward(obj, inputs, params, derOutputs)
      derInputs{1} = vl_nnreshape(inputs{1}, obj.shape, derOutputs{1}) ;
      derParams = {} ;
    end

    function outputSizes = getOutputSizes(obj, inputSizes)
     
        batchsize = inputSizes{1,1}(4);
        outputSizes{1} = [obj.shape{1} obj.shape{2} obj.shape{3} batchsize] ;
      
    end

    function rfs = getReceptiveFields(obj)
    end

    function load(obj, varargin)
      s = dagnn.Layer.argsToStruct(varargin{:}) ;
      load@dagnn.Layer(obj, s) ;
    end

    function obj = Reshape(varargin)
      obj.load(varargin{:}) ;
    end
  end
end
