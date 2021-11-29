<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<jsp:useBean class="webproject.teamrankBean" id="teamrankBean"/>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>야구</title>
    <link rel="stylesheet" href="./style.css">
    <script>

    </script>
</head>
<body>
<jsp:include page="./header.jsp" />
<section>
    <article id="schedule" class="sec">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try{
                Context initContext = new InitialContext();
                Context envContext = (Context)initContext.lookup("java:/comp/env");
                DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
                conn = ds.getConnection();

                String sql = "select *,unix_timestamp(date) from ( select * from dongyang.Schedule order by date desc LIMIT 5) a order by date";

                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                System.out.println(rs);
        %>
        <h2>KBO 일정</h2>
        <hr>
        <%!
            public String convertTag(String str) {
                String val = str;
                switch (str){
                    case "삼미":
                    case "청보":
                    case "태평양":
                    case "현대":
                        val = "HD";
                        break;
                    case "쌍방울":
                        val = "SB";
                        break;
                    case "OB":
                    case "두산":
                        val = "OB";
                        break;
                    case "해태":
                    case "KIA":
                        val = "HT";
                        break;
                    case "LG":
                    case "MBC":
                        val = "LG";
                        break;
                    case "빙그레":
                    case "한화":
                        val = "HH";
                        break;
                    case "히어로즈":
                    case "넥센":
                    case "우리":
                    case "키움":
                        val = "WO";
                        break;
                    case "삼성":
                        val = "SS";
                        break;
                    case "롯데":
                        val = "LT";
                        break;
                    case "SK":
                    case "SSG":
                        val = "SK";
                        break;
                    case "NC":
                    case "KT":
                        break;

                }
                return val;

            }
        %>

        <% while (rs.next()){
            System.out.println(rs.getObject(1));
            String date = rs.getString("date");
            String away = rs.getString("away");
            String home = rs.getString("home");
            String awayScore = rs.getString("awayScore");
            String homeScore = rs.getString("homeScore");
            String stadium = rs.getString("stadium");
            String note = rs.getString("note");
            Date compare = new Date(rs.getLong("unix_timestamp(date)"));
            Date now = new Date();

            String time = date.split(" ")[1].substring(0,5);
            date = date.split(" ")[0].split("-")[1]+"월 "+date.split(" ")[0].split("-")[2]+"일";
            if(!note.equals("-"))
                time = note;
            if (now.compareTo(compare) > 0) {
                time = "경기종료";
            }
        %>
        <div class="schedule_item">
            <div class="date">
                <b> <%= stadium %> </b>| <%=time%>
            </div>
            <div class="versus">
                <br>
                <table>
                    <tr>
                        <td style="padding: 0.25em 0 0.5em 0;font-size: 1.25em" colspan="3"><%=date%></td>
                    </tr>
                    <tr>
                        <td><img src="./img/emblem_<%=convertTag(away)%>.png" alt=<%=away%>></td>
                        <td rowspan="4">vs</td>
                        <td><img src="./img/emblem_<%=convertTag(home)%>.png" alt=<%=home%>></td>
                    </tr>
                    <tr>
                        <td><%=away%></td>
                        <td><%=home%></td>
                    </tr>
                    <tr>
                        <td style="font-weight: bold;font-size: 1.25em" rowspan="2"> <%=awayScore%></td>
                        <td style="font-weight: bold;font-size: 1.25em" rowspan="2"> <%=homeScore%></td>
                    </tr>
                    <tr></tr>
                </table>
            </div>
            <div class="weather">
                <table>
                    <tr>
                        <td colspan="3" class="highlight_lightgrey">현재 날씨</td>
                    </tr>
                    <tr>
                        <td>
                            <img src="./img/weather/03_s.png" alt="">
                        </td>
                        <td>
                            <img src="./rain_s.png" alt="">
                        </td>
                        <td>
                            <img src="./img/weather/01_xs.png" alt="">
                        </td>
                    </tr>
                    <tr>
                        <td>구름 조금</td>
                        <td>강수확률</td>
                        <td>(초)미세먼지</td>
                    </tr>
                    <tr>
                        <td>12℃</td>
                        <td>10%</td>
                        <td>좋음</td>
                    </tr>
                </table>
            </div>
        </div>
        <%
                }
            } catch (Exception e){
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
                if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
                if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
            }
        %>
    </article>
    <article id="rank" class="sec">
        <div id="player_rank">
            <h2>플레이어 랭킹</h2>
            <hr>
            <table>
                <tr id="rank_select">
                    <td>타자</td>
                    <td>투수</td>
                    <td>주간 랭킹</td>
                </tr>
                <tr id="rank_data">
                    <td colspan="3">
                        <table id="hitter_rank">
                        <tr>
                            <td colspan="2">타율</td>
                            <td colspan="2">홈런</td>
                            <td colspan="2">타점</td>
                        </tr>
                        <tr>
                            <td>1위</td>
                            <td><img src="./img/player/67341.png" alt=""> 이정후(키움)<br>0.362</td>
                            <td>1위</td>
                            <td><img src="./img/player/62947.png" alt="">나성범(NC)<br>31</td>
                            <td>1위</td>
                            <td><img src="./img/player/76232.png" alt="">양의지(NC)<br>102</td>
                        </tr>
                        <tr>
                            <td>2위</td>
                            <td>강백호(KT)<br>0.362</td>
                            <td>1위</td>
                            <td>최정(SSG)<br>31</td>
                            <td>2위</td>
                            <td>강백호(KT)<br>102</td>
                        </tr>
                        <tr>
                            <td>3위</td>
                            <td>전준우(롯데)<br>0.362</td>
                            <td>3위</td>
                            <td>알테어(NC)<br>31</td>
                            <td>3위</td>
                            <td>피렐라(삼성)<br>102</td>
                        </tr>
                    </table>
                        <table id="pitcher_rank" style="display: none">
                            <tr>
                                <td colspan="2">평균자책점</td>
                                <td colspan="2">승리</td>
                                <td colspan="2">탈삼진</td>
                            </tr>
                            <tr>
                                <td>1위</td>
                                <td><img src="#" alt="">미란다(두산)<br>2.38</td>
                                <td>1위</td>
                                <td><img src="#" alt="">요키시(키움)<br>15</td>
                                <td>1위</td>
                                <td><img src="#" alt="">미란다(두산)<br>211</td>
                            </tr>
                            <tr>
                                <td>2위</td>
                                <td>요키시(키움)<br>2.61</td>
                                <td>1위</td>
                                <td>뷰캐넌(삼성)<br>15</td>
                                <td>2위</td>
                                <td>카펜터(한화)<br>162</td>
                            </tr>
                            <tr>
                                <td>3위</td>
                                <td>백정현(삼성)<br>2.69</td>
                                <td>3위</td>
                                <td>루친스키(NC)<br>14</td>
                                <td>3위</td>
                                <td>데스파이네(KT)<br>160</td>
                            </tr>
                        </table>
                        <table id="week_rank" style="display: none">
                            <tr>
                                <td colspan="2">타율</td>
                                <td colspan="2">홈런</td>
                                <td colspan="2">안타</td>
                            </tr>
                            <tr>
                                <td>1위</td>
                                <td><img src="#" alt="">오태곤(SSG)<br>0.362</td>
                                <td>1위</td>
                                <td><img src="#" alt="">피렐라(삼성)<br>2</td>
                                <td>1위</td>
                                <td><img src="#" alt="">전준우(롯데)<br>102</td>
                            </tr>
                            <tr>
                                <td>2위</td>
                                <td>전준우(롯데)<br>0.362</td>
                                <td>1위</td>
                                <td>박병호(키움)<br>2</td>
                                <td>2위</td>
                                <td>이정후(키움)<br>102</td>
                            </tr>
                            <tr>
                                <td>3위</td>
                                <td>유한준(KT)<br>0.362</td>
                                <td>1위</td>
                                <td>크레익(키움)<br>2</td>
                                <td>3위</td>
                                <td>박병호(키움)<br>102</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            </div>
            <div id="team_rank">
                <h2>팀 랭킹</h2>
                <p>10월 16일 기준</p>
                <hr>
                <%
                    conn = null;
                    pstmt = null;
                    rs = null;

                    try{
                        Context initContext = new InitialContext();
                        Context envContext = (Context)initContext.lookup("java:/comp/env");
                        DataSource ds = (DataSource)envContext.lookup("jdbc/mysql");
                        conn = ds.getConnection();

                        String sql = "select * from dongyang.TeamRank where YEAR=2021 order by `RANK`";
                        pstmt = conn.prepareStatement(sql);

                        rs = pstmt.executeQuery();
                        System.out.println(rs);
                %>
                <table>
                    <tr class="highlight_lightgrey bordering_lightgrey">
                        <td class="bordering_lightgrey">순위</td>
                        <td>팀명</td>
                        <td>경기</td>
                        <td>승</td>
                        <td>패</td>
                        <td>무</td>
                        <td>승률</td>
                        <td>게임차</td>
                        <td>연속</td>
                    </tr>
                    <% while (rs.next()){
                        System.out.println(rs.getObject(1));
                        String rank = rs.getString("RANK");
                        String team = rs.getString("TEAM");
                        String games = rs.getString("GAMES");
                        String win = rs.getString("WIN");
                        String lose = rs.getString("LOSE");
                        String draw = rs.getString("DRAW");
                        String rate = rs.getString("RATE");
                        String gap = rs.getString("GAP");
                        String straight = rs.getString("STRAIGHT");
                    %>
                    <tr>
                        <td><%= rank %></td>
                        <td><%= team %></td>
                        <td><%= games %></td>
                        <td><%= win %></td>
                        <td><%= lose %></td>
                        <td><%= draw %></td>
                        <td><%= rate %></td>
                        <td><%= gap %></td>
                        <td><%= straight %></td>
                    </tr>
                    <% } %>
                </table>
                <%
                    } catch (Exception e){
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch(SQLException ex) {ex.printStackTrace();}
                        if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {ex.printStackTrace();}
                        if (conn != null) try { conn.close(); } catch(SQLException ex) {ex.printStackTrace();}
                    }
                %>
            </div>
        </article>
    </section>
    <jsp:include page="./footer.jsp" />
</body>
</html>
