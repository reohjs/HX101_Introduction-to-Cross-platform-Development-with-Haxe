import mcli.*;

class Helper extends CommandLine {
    static function main():Void {
        new mcli.Dispatch(Sys.args()).dispatch(new Helper());
    }
}