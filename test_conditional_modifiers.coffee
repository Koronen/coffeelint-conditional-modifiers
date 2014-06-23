vows = require 'vows'
assert = require 'assert'
coffeelint = require 'coffeelint'

vows.describe('conditional_modifiers').addBatch({

    'Conditional modifiers' :

        topic : () ->
            '''
            number = -42 if opposite
            letTheWildRumpusBegin() unless answer is no
            '''

        'reports use of conditional modifiers' : (source) ->
            config = {conditional_modifiers : {module : './conditional_modifiers'}}
            errors = coffeelint.lint(source, config)
            assert.isArray(errors)
            assert.lengthOf(errors, 2)
            error = errors[0]
            assert.equal(error.lineNumber, 1)
            assert.equal(error.message, 'Conditional modifiers are forbidden')
            assert.equal(error.rule, 'conditional_modifiers')

}).export(module)
