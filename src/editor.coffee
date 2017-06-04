module.exports =
class Editor
    constructor: (@loader) ->
        editorWidthPercentage = 30;
        hasShow = true
        $editorBox = $($.parseHTML '<div id = "editor-column" class="column"></div>')
        $editorBox.width(editorWidthPercentage+'%')
        $('#net-column').width((100-editorWidthPercentage)+'%')
        $('#master-container').prepend $editorBox
        @editor = CodeMirror $editorBox[0],
            value: '# Enter your network definition here.\n# Use Shift+Enter to update the visualization.\n# double click to control the editor hide or show'
            lineNumbers : true
            lineWrapping : true
        @editor.on 'keydown', (cm, e) => @onKeyDown(e)
        $('#net-column').on 'dblclick', () =>
            if hasShow is true
                hasShow = false
                $("#editor-column").hide();
                $('#editor-column').width(0+'%')
                $('#net-column').width(100+'%')
            else
                hasShow = true
                $("#editor-column").show();
                $('#editor-column').width(30+'%')
                $('#net-column').width(70+'%')

    onKeyDown: (e) ->
        if (e.shiftKey && e.keyCode==13)
            # Using onKeyDown lets us prevent the default action,
            # even if an error is encountered (say, due to parsing).
            # This would not be possible with keymaps.
            e.preventDefault()
            @loader @editor.getValue()
